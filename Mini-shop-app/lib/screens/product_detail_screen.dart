import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
//When item from the items grid view is being pressed - this is the screen with the details about the product
class ProductDetailScreen extends StatelessWidget {
  static const String routName = 'ProductDetailScreen';


  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);
    SizedBox space =   SizedBox(height: 10);
    final id = ModalRoute.of(context).settings.arguments as String;

    // listen: false -> get the data from the provider one time, and stop listen to updates
    // In my app - I am calling notifyListeners() from inside "Products" provider after an item is added to the list
    // I don`t need this new data here and want to prevent it from affecting this widget and make it re-build.
    final loadedProduct = Provider.of<Products>(context, listen: false).findProductById(id);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: mediaQuery.size.height * 0.5,
              width: mediaQuery.size.width * 1,
              alignment: Alignment(0.0, 0.0),
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
            ),
            space,
            Text('\$${loadedProduct.price}', style: TextStyle(color: Colors.grey, fontSize: 20)),
            space,
            Container(
              width: mediaQuery.size.width * 0.95,
                child: Text(
                    '${loadedProduct.description}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black54),
                    textAlign: TextAlign.center,
                    softWrap: true)
            ),
          ],
        ),
      ),

    );
  }
}
