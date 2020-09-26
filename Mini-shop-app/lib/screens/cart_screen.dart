import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const String routName = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("your cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("total", style: TextStyle(fontSize: 20)),
                  Spacer(),
                  //Element with rounded corners to display information
                  Chip(
                    label: Text(('\$${cart.totalCartItemAmount}'),
                    style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {  },
                    child: Text("place your order"),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
