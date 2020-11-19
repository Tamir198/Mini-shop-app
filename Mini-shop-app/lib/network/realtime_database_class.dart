import 'dart:convert';

import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class RealtimeDatabaseClass {

  //When wrapping function with async it will automatically return a future
  Future addProduct(Product product, List<Product> items) async {

    const String url = 'https://udemy-shop-app-course.firebaseio.com/products.json';
    //Converting data to json json.encode() knows how to convert maps to json
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

      items.add(newProduct);

    }catch(error){
      print(error);
      throw error;
    }
  }
}