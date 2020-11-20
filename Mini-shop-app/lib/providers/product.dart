import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

//This is model for the product - the items in the shop
//This is provided class (data that I will send to the provider) because isFavorite can be changed and I
//want to tell all listeners that the data has been changed

class Product with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false});

  void toggleFavorite() async {
    //Saves original status for optimistic updating
    final bool oldStatus = isFavorite;
    isFavorite = !isFavorite;
    //Tell the listeners that Item favorite state has changes
    notifyListeners();
    final String url = 'https://udemy-shop-app-course.firebaseio.com/products/$id.json';
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));

      if (response.statusCode >= 400) {
        //If the request to the server failed roll back everything
        _updateIsFav(oldStatus);
      }
    } catch (e) {
      //If the request to the server failed roll back everything
      _updateIsFav(oldStatus);
    }
  }

  void _updateIsFav(bool value) {
    isFavorite = value;
    notifyListeners();
  }
}
