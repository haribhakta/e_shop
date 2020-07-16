import 'package:e_shop/wigdets/product_grid.dart';
import 'package:flutter/material.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showfavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-shop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  _showfavorites = true;
                } else {
                  _showfavorites = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: FilterOptions.Favorites,
                  child: Text("Show Favourites")),
              PopupMenuItem(value: FilterOptions.All, child: Text("Show All")),
            ],
          ),
        ],
      ),
      body: ProductGrid(_showfavorites),
    );
  }
}
