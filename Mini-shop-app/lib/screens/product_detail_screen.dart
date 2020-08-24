
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//When item from the items grid view is being pressed - this is the screen with the details about the product
class ProductDetailScreen extends StatelessWidget {
  static const String routName = 'ProductDetailScreen';




  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('title')),
    );
  }
}
