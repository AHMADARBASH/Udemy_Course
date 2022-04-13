import 'package:flutter/material.dart';
import 'package:shop_app/models/http_Exceptions.dart';
import 'product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String? authToken;
  final String? userID;

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favs {
    return _items.where((element) => element.isFavorite).toList();
  }

  Products(
    this.authToken,
    this.userID,
    this._items,
  );
  //fetch data from firebase
  Future<void> fetchandSetProducts([bool filterByUser = false]) async {
    var url;
    if (filterByUser == false) {
      url = Uri.parse(
          'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
    } else {
      url = Uri.parse(
          'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken&orderBy="creatorID"&equalTo="$userID"');
    }

    try {
      final request = await http.get(url);
      final Map<String, dynamic>? extractedData = json.decode(request.body);
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      url = Uri.parse(
          'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userID.json?auth=$authToken');
      final favoritResponse = await http.get(url);
      final favoriteProducts = json.decode(favoritResponse.body);
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(Product(
          id: prodID,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favoriteProducts == null
              ? false
              : favoriteProducts[prodID] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //save data to firebase
  Future<void> addProduct(Product newProduct) async {
    final url =
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'creatorID': userID,
          }));
      final recivedProduct = Product(
          description: newProduct.description,
          imageUrl: newProduct.imageUrl,
          title: newProduct.title,
          price: newProduct.price,
          id: json.decode(response.body)['name']);
      _items.add(recivedProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Product findbyID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  //update product method
  Future<void> updateProdcut(prodID, Product newProduct) async {
    final url = Uri.parse(
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/products/$prodID.json?auth=$authToken');

    final productindex = _items.indexWhere((element) => element.id == prodID);
    if (productindex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price
            }));
      } catch (e) {
        rethrow;
      }
      _items[productindex] = newProduct;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> deleteProduct(prodID) async {
    final existingProdutctIndex =
        _items.indexWhere((element) => element.id == prodID);
    Product? exitstingProduct = _items[existingProdutctIndex];
    final url = Uri.parse(
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/products/$prodID.json?auth=$authToken');

    final deletedProduct =
        _items.removeWhere((element) => element.id == prodID);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdutctIndex, exitstingProduct);
      notifyListeners();
      throw HttpException(message: 'Couldn\'t Delete Prodcut.');
    }
    exitstingProduct = null;
  }
}
