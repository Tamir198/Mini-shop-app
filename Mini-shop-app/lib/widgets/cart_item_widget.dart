import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id, productId, title;
  final double price;
  final int quantity;

  const CartItemWidget(
      this.id, this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    EdgeInsets cardMargin = EdgeInsets.symmetric(horizontal: 15, vertical: 4);
    //Swipe to delete
    return Dismissible(
      //From the docs:
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 35),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
        margin: cardMargin,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //Dialog to gonfirm
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Are you sure?"),
                  content:
                      Text("Would you like to remove the item from the cart?"),
                  actions: <Widget>[
                    //Close the Dialog and pass a value, because showDialog is returning a future
                    FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                    FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        })
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeCartItem(productId);
      },
      child: Card(
        margin: cardMargin,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(child: Text('\$$price')))),
              title: Text(title),
              subtitle: Text('Total: \$${(quantity * price)}'),
              trailing: Text('$quantity x'),
            )),
      ),
    );
  }
}
