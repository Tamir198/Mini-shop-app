import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../widgets/order_items_widget.dart';

import '../widgets/custom_drawer/drawer_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routName = 'orders';

  @override
  Widget build(BuildContext context) {

    final Orders ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('your orders')
      ),
      drawer: AppDrawerWidget(),
      body: ListView.builder(itemBuilder: (context, i) => OrderItemWidget(ordersData.orders[i]),
          itemCount: ordersData.orders.length),
    );
  }
}
