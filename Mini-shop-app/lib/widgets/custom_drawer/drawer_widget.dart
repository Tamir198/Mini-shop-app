import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_products_screen.dart';

import '../../screens/orders_screen.dart';
import 'drawer_item_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
            title: Text("Hey"),
            //Don`t add "back" button like in android
            automaticallyImplyLeading: false
        ),
        Divider(),
        DrawerItem(routName: '/', title: "shop", icon: Icon(Icons.shop)),
        Divider(),
        DrawerItem(routName: OrdersScreen.routName, title: "Orders", icon: Icon(Icons.payment)),
        Divider(),
        DrawerItem(routName: UserProductScreen.routName, title: "Manage products", icon: Icon(Icons.edit)),

      ],),
    );
  }
}
