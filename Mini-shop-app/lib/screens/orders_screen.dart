import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'file:///C:/Users/The%20Vegan/Desktop/shopAppGit/Mini-shop-app/Mini-shop-app/lib/widgets/custom_drawer/drawer_widget.dart';
import 'package:shop_app/widgets/order_items_widget.dart';

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
