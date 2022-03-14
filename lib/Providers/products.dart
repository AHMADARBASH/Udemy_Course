import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dHJvdXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://media.istockphoto.com/photos/overhead-of-cast-iron-fry-pan-picture-id966981420?b=1&k=20&m=966981420&s=170667a&w=0&h=oOCW0LbNhCVEdZ6eFhzJmVrwaZWG8gROUIDvb9TIkPA=',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favs {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product newProduct) {
    final recivedProduct = Product(
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        title: newProduct.title,
        price: newProduct.price,
        id: DateTime.now().toString());
    _items.add(recivedProduct);
    notifyListeners();
  }

  Product findbyID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateProdcut(prodID, Product newProduct) {
    final productindex = _items.indexWhere((element) => element.id == prodID);
    if (productindex >= 0) {
      _items[productindex] = newProduct;
      notifyListeners();
    } else {
      return;
    }
  }

  void deleteProduct(prodID) {
    final deletedProduct =
        _items.removeWhere((element) => element.id == prodID);
    notifyListeners();
  }
}
