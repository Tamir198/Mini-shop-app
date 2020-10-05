import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get cartItemsNum {
    return _cartItems == null ? 0 : _cartItems.length;
  }

  double get totalCartItemAmount {
    double total = 0.0;

    _cartItems.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });

    return total;
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
    notifyListeners();
  }

  void removeCartItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }

  void removeSingleItem(String id) {

    if (!_cartItems.containsKey(id)) {
      return;
    }

    if (_cartItems[id].quantity > 1) {
      _cartItems.update(
          id,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity - 1));
    } else {
      _cartItems.remove(id);
    }
    notifyListeners();
  }
}
