import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
//When item from the items grid view is being pressed - this is the screen with the details about the product
class ProductDetailScreen extends StatelessWidget {
  static const String routName = 'ProductDetailScreen';


  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    // listen: false -> get the data from the provider one time, and stop listen to updates
    // In my app - I am calling notifyListeners() from inside "Products" provider after an item is added to the list
    // I don`t need this new data here and want to prevent it from affecting this widget and make it re-build.
    final loadedProduct = Provider.of<Products>(context, listen: false).findProductById(id);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
    );
  }
}
