import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems;

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  void addToCartItems(String productId, double price, String title) {
    if (_cartItems.containsKey(productId)) {
      
      //If exist just change quantity
      _cartItems.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              price: existingItem.price,
              title: existingItem.title,
              quantity: existingItem.quantity + 1));

    } else {

      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));

    }
  }
}