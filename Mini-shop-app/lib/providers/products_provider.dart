

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/network/realtime_database_class.dart';
import 'package:http/http.dart' as http;


import './product.dart';

//TL;DR - this is a class that will be provided to the provider
//This is a class is the provides class to some provider - this class holds the data that will be register
//to the provider
// ChangeNotifier - provides change notification to its listeners with notifyListeners()

//The data of the provider

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  bool _shouldShowFavoritesOnly = false;

  //Return a copy of items so I can change items in the class and call notifyListeners();
  List<Product> get items {
    // ... is called spread operator
    return [..._items];
  }

  List<Product> get favorites {
    // ... is called spread operator
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findProductById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {

     //RealtimeDatabaseClass().addProduct(product, items);
      const String url = 'https://udemy-shop-app-course.firebaseio.com/products.json';

      //Converting data to json, json.encode() knows how to convert maps to json
      try{

        final http.Response response = await http.post(url,

            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite,
            }));
        //Tell all ChangeNotifier listeners that data was updated
        Product newProduct = Product(
            title: product.title,
            price: product.price,
            imageUrl: product.imageUrl,
            description: product.description,
            id: json.decode(response.body)['name']);

        _items.add(newProduct);

      }catch(error){
        print(error);
        throw error;
      }
     notifyListeners();
     print("items are $items");
  }

  void updateProduct(String id, Product newProduct) {
    int productIndex = _items.indexWhere((product) => product.id == id);

    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
