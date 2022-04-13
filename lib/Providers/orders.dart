import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  String? authToken;
  String? userID;

  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Orders(this.authToken, this.userID, this._orders);

  Future<void> fetchandSetOrders() async {
    final url = Uri.parse(
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/orders/$userID.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];

    final Map<String, dynamic>? extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      loadedOrders.add(OrderItem(
          id: orderID,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  qty: e['qty'],
                  price: e['price']))
              .toList()));
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/orders/$userID.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'qty': e.qty,
                    'price': e.price
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
