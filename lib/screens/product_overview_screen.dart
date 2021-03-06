import 'package:e_shop/provider/cart_provider.dart';
import 'package:e_shop/provider/products_provider.dart';
import 'package:e_shop/wigdets/badge.dart';
import 'package:e_shop/wigdets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';
import '../wigdets/app_drawer.dart';

//show or not show favourites
enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const String routeName = "/product_overview_screen";
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Shop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  _showFavourites = true;
                } else {
                  _showFavourites = false;
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
          Consumer<Cart>(
            builder: (ctx, cart, child) {
              return Badge(
                value: cart.itemCount.toString(),
                child: child,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
       drawer: AppDrawer(),
      body: FutureBuilder(
        future:
        Provider.of<Products>(context, listen: false).fetchAndSetProducts(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ProductGrid(_showFavourites),
      ),
    );
  }
}
