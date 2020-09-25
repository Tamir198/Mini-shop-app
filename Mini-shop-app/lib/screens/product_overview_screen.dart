
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum SelectedPopupMenu {
Favorites, All
}


class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _shouldShowFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (SelectedPopupMenu selected){
              setState(() {
                //Change the data that inside the provider
                if(selected == SelectedPopupMenu.All){
                  _shouldShowFavoritesOnly = false;
                }else{
                  _shouldShowFavoritesOnly = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(child: Text("Favorites"),value: SelectedPopupMenu.Favorites),
              PopupMenuItem(child: Text("Show All"),value: SelectedPopupMenu.All),
          ],)
        ],
      ),
      body: ProductsGridView(_shouldShowFavoritesOnly),
    );
  }
}
