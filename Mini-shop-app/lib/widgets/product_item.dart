import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

//This is the item that will get rendered for every greed view item as product
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //One way to listen to provider
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);

    final Color iconColor = Theme.of(context).accentColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      //Because GridTile don`t have on click method I am wrapping it with GestureDetector
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            //Consumer is another way to listen to provider, by doing it like this only this part will get rebuild and npt entire widget tree
            leading: Consumer<Product>(
                builder: (BuildContext context, product, Widget child) =>
                    IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: iconColor,
                      onPressed: () {
                        product.toggleFavorite();
                      },
                    )),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: iconColor,
              onPressed: () {
                cart.addToCartItems(product.id, product.price, product.title);
                //Search for the nearest scaffold and show pop up
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Item added to cart"),
                    action: SnackBarAction(label:"Undo",
                      onPressed: () {
                          cart.removeSingleItem(product.id);
                      },),
                    duration: Duration(seconds: 2)));
              },
            ),
            title: Text(product.title, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
