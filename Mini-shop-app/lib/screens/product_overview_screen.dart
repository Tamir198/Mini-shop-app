import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum SelectedPopupMenu { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _shouldShowFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (SelectedPopupMenu selected) {
              setState(() {
                //Change the data that inside the provider
                if (selected == SelectedPopupMenu.All) {
                  _shouldShowFavoritesOnly = false;
                } else {
                  _shouldShowFavoritesOnly = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) =>
            [
              PopupMenuItem(
                  child: Text("Favorites"), value: SelectedPopupMenu.Favorites),
              PopupMenuItem(
                  child: Text("Show All"), value: SelectedPopupMenu.All),
            ],
          ),
          Consumer<Cart>(
              builder: (BuildContext context, cart, Widget childOfConsumer) =>
                  Badge(
                      child: childOfConsumer,
                      value: cart.cartItemsNum.toString()),
              //The child of the consumer, it wont get re build, this is passed to the builder as the
              //childOfConsumer argument
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
          ),
        ],
      ),
      body: ProductsGridView(_shouldShowFavoritesOnly),
    );
  }
}
