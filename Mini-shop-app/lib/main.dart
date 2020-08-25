import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/products_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider - this is my provider came from provider package
    //EVERY child widget that will listen to the provider will rebuild on data changed, so the provider
    //provides data to its children's to listen to
    //This is why he provider must be above  those children's who need the data in the widget tree
    return ChangeNotifierProvider(
      //Products is the instance class that provided by provider
      create: (BuildContext context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routName : (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}

