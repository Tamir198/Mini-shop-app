import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//This is the item that will get rendered for every greed view item as product
class ProductItem extends StatelessWidget {
  final String id, title, imageUrl;


  const ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final Color iconColor =  Theme.of(context).accentColor;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite),
             color: iconColor,
            onPressed: () {  },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: iconColor,
            onPressed: () {  },
          ),
          title: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
