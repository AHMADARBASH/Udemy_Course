import 'dart:convert';
import 'dart:math';
import 'dart:async';
import '../models/http_Exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  String? get userID {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _userID != null) {
      return _userID!;
    }
    return null;
  }

  Future<void> authenticateUser(
      String email, String password, String authtype) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$authtype?key=AIzaSyDBT3vtvogJjm4rEb4-y5N0vFQrqj1dA0M');

    try {
      final repsonse = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(repsonse.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userID = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      autoLogout();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticateUser(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return authenticateUser(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _userID = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    notifyListeners();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    Timer(
        Duration(
          seconds: timeToExpire,
        ),
        logout);
  }
}
