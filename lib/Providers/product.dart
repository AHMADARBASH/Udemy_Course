import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_Exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> togglefavorite(
      String id, Product product, String authToken, String userID) async {
    final url = Uri.parse(
        'https://flutter-training-7b362-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userID/$id.json?auth=$authToken');
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException(message: 'error favorite item.');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
      rethrow;
    }

    notifyListeners();
  }
}
