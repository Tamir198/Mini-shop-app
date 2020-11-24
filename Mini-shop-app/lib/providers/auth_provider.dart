import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app/network/custon_exeption.dart';

class AuthProvider with ChangeNotifier{

  String _token;
  DateTime _expiredDate;
  String _userId;

  //For more info about the parameters and request:
  //https://firebase.google.com/docs/reference/rest/auth#section-create-email-password

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDVByjrBJyTbnYhlCEmkPe6_gnOTqDPV64';

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
      if(responseData['error'] != null){
        print(responseData['error']);
        throw CustomException(responseData['error']['message']);
      }

    } catch (error) {
      throw(error);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
