//This is Data class representing how should the cart item look like

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime timeOfOrder;

  OrderItem({@required this.id, @required this.amount, @required this.products, @required this.timeOfOrder});



}