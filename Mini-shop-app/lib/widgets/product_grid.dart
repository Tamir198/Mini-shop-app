import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool _showFavorites;

  ProductsGridView(this._showFavorites);


  @override
  Widget build(BuildContext context) {
    //Set connection to provided class and listen to changes
    //Only this widget and sub children will get re build when the provided class data will change
    //Provider.of is generic method, <Products> is the type of data I want to listen to
    final productsData  = Provider.of<Products>(context);
    final products = _showFavorites ? productsData.favorites :productsData.items;
    return GridView.builder(
      //structure of the greed (how many columns rows...)
      //SliverGridDelegateWithFixedCrossAxisCount - show certain amount of item on the screen
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //how many columns
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        //Space between columns
        crossAxisSpacing: 10,
        //Space between rows
        mainAxisSpacing: 10,
      ),
      //What will be displayed on the screen
      itemBuilder: (context, item) => ChangeNotifierProvider.value(
        //This provider is to tell if the item is favorite or not
        //IMPORTANT - for every product item I am using new provider
        value: products[item],
        child: ProductItem(),
      ),
      itemCount: products.length,
      //const prevent padding from being rebuild for every time build() is called
      padding: const EdgeInsets.all(10.0),
    );
  }
}