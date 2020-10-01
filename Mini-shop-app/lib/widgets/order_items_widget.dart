import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;

  const OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd/mm/yyyy hh:mm')
                .format(widget.order.timeOfOrder)),
            trailing: IconButton(
              icon: _isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.00 + 10, 100),
              child: ListView(
                children: widget.order.products.map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                product.title,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                            ),
                            Text(
                                '${product.quantity} x \$ ${product.price}'
                                ,style: TextStyle(fontSize: 18, color: Colors.grey))
                          ],
                        )
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}
