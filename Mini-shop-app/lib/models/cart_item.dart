//This is Data class representing how should the cart item look like

import 'package:flutter/cupertino.dart';

class CartItem {
  final String id, title;
  final int quantity;
  final double price;

  CartItem({@required this.id,@required this.title,@required this.quantity,@required this.price});


}