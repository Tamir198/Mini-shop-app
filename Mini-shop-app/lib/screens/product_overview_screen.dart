import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../providers/cart_provider.dart';

import '../screens/cart_screen.dart';

import '../widgets/badge_widget.dart';
import '../widgets/product_grid.dart';
import '../widgets/custom_drawer/drawer_widget.dart';

enum SelectedPopupMenu { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _shouldShowFavoritesOnly = false;
  bool isInit = true, isLoading = false;


  //Using initState would not work because the context is not available yet,
  //This  lifecycle runs a lot of times, this is the reason for isInit
  @override
  void didChangeDependencies() {
    isLoading = true;
    if (isInit) {
      Provider.of<Products>(context, listen: false).fetchAndDisplayProducts();
    }
    isInit = false;
    super.didChangeDependencies();
  }



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
                  BadgeWidget(
                      child: childOfConsumer,
                      value: cart.cartItemsNum.toString()),
              //The child of the consumer, it wont get re build, this is passed to the builder as the
              //childOfConsumer argument
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routName);
                },
              ),
          ),
        ],
      ),
      drawer: AppDrawerWidget(),
      body: ProductsGridView(_shouldShowFavoritesOnly),
    );
  }
}
