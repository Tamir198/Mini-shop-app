import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';


class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {

    _orders.insert(0,OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        timeOfOrder: DateTime.now(),
        products: cartProducts
    ));

    notifyListeners();

  }
}