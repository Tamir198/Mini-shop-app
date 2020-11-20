import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class RealtimeDatabaseClass {
  final String url = 'https://udemy-shop-app-course.firebaseio.com/products.json';

  //When wrapping function with async it will automatically return a future
  Future addProduct(Product product, List<Product> items) async {
    //Converting data to json json.encode() knows how to convert maps to json
    try {
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

      items.add(newProduct);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future fetchData(List<Product> items) async {
    var response;
    try {

      response = await http.get(url);

      final Map<String, dynamic> data = json.decode(response.body);

      print(json.decode(response.body));
      if(data == null) return;
      data.forEach((productId, value) {
        items.add(Product(
            id: productId,
            title: value['title'],
            description:value['description'] ,
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavorite: value['isFavorite'],
        ));

      });
    } catch (error) {
      print(error);
    }
    return response;
  }

}
