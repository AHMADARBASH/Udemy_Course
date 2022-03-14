import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.qty,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.price * cartitem.qty;
    });
    return total;
  }

  void addItem({String? productID, double? price, String? title}) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID!,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              qty: value.qty + 1));
    } else {
      _items.putIfAbsent(
        productID!,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title!,
            price: price!,
            qty: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String ProdcutId) {
    if (!_items.containsKey(ProdcutId)) {
      return;
    }
    if (_items[ProdcutId]!.qty > 1) {
      _items.update(
          ProdcutId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              qty: value.qty - 1,
              price: value.price));
    } else {
      _items.remove(ProdcutId);
    }
    notifyListeners();
  }

  void minusItem(String prodcutId) {
    _items.update(
        prodcutId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            qty: value.qty - 1));
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
