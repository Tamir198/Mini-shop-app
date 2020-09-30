import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import '../widgets/cart_item_widget.dart';
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
                    label: Text(('\$${cart.totalCartItemAmount.toStringAsFixed(2)}'),
                    style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalCartItemAmount);
                      cart.clearCart();
                    },
                    child: Text("place your order"),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: ListView.builder(
            itemBuilder: (context, i) => CartItemWidget(
              //values.toList()[i] -> get the values that are stored in the map
               cart.items.values.toList()[i].id,
               cart.items.keys.toList()[i],
               cart.items.values.toList()[i].title,
               cart.items.values.toList()[i].price,
               cart.items.values.toList()[i].quantity,
           ),
            itemCount: cart.cartItemsNum
          )
          )],
      ),
    );
  }
}
