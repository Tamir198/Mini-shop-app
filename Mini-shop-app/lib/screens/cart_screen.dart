import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

import '../widgets/cart_item_widget.dart';

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
                  OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      //In flutter when onPressed point null the button is disabled
      onPressed: (widget.cart.totalCartItemAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });

        await Provider.of<Orders>(context, listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalCartItemAmount);
        setState(() {
          _isLoading = false;
        });
        widget.cart.clearCart();
      },
      child: _isLoading ? CircularProgressIndicator() : Text("place your order"),
      textColor: Theme.of(context).primaryColor,
    );
  }
}

