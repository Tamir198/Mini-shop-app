import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/custom_drawer/drawer_widget.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const String routName = "UserProductScreenRout";

  @override
  Widget build(BuildContext context) {
    final Products productsDate = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        //Adding const so the items will not rebuild - they don`t need to change
        title: const Text("Your products"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routName);
              })
        ],
      ),
      drawer: AppDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsDate.items.length,
          itemBuilder: (context, i) => Column(
            children: <Widget>[
              UserProductItem(
                title: productsDate.items[i].title,
                imageUrl: productsDate.items[i].imageUrl,
                id: productsDate.items[i].id,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
