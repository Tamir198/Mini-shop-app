import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app/network/custon_exeption.dart';

class AuthProvider with ChangeNotifier {
  DateTime _expiredDate;
  String _userId;
  String _token;

  bool get isAuthenticate {
    return token != null;
  }


  String get token {
    if (_expiredDate != null &&
        _expiredDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //For more info about the parameters and request:
  //https://firebase.google.com/docs/reference/rest/auth#section-create-email-password

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDVByjrBJyTbnYhlCEmkPe6_gnOTqDPV64';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData['error']);
        throw CustomException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiredDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();

    } catch (error) {
      throw (error);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
