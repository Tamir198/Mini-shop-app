import 'package:flutter/cupertino.dart';
//This is model for the product - the items in the shop
class Product {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false
  });
}
