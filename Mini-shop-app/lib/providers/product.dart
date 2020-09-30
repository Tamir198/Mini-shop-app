import 'package:flutter/cupertino.dart';

//This is model for the product - the items in the shop
//This is provided class (data that I will send to the provider) because isFavorite can be changed and I
//want to tell all listeners that the data has been changed

class Product with ChangeNotifier{
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false
  });

  void toggleFavorite(){
    isFavorite = !isFavorite;
    //Tell the listeners that Item favorite state has changes
    notifyListeners();
  }

}
