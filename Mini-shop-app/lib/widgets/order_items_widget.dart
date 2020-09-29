import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;

  const OrderItemWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${order.amount}'),
          subtitle: Text(DateFormat('dd/mm/yyyy hh:mm').format(order.timeOfOrder)),
          trailing: IconButton(icon: Icon(Icons.expand_more),
            onPressed: () {

          },),
        ),

      ],
      ),
    );
  }
}
