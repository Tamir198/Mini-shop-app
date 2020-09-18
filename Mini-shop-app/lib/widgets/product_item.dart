import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

//This is the item that will get rendered for every greed view item as product
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context);
    final Color iconColor = Theme.of(context).accentColor;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      //Because GridTile don`t have on click method I am wrapping it with GestureDetector
      child: GestureDetector(
        onTap: () {
       
          Navigator.of(context).pushNamed(ProductDetailScreen.routName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: iconColor,
              onPressed: () {
                product.toggleFavorite();
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: iconColor,
              onPressed: () {},
            ),
            title: Text(product.title, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
