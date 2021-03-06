import 'package:e_shop/models/product.dart';
import 'package:e_shop/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ProductItem extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final selectedProduct = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: selectedProduct.id);
          },
          child: Image.network(
            selectedProduct.imageURL,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(selectedProduct.title, textAlign: TextAlign.center),
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                icon: product.isFavourite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () async {
                  String apiToken = await _auth.currentUser.getIdToken();
                  await product.toggleFavourite(
                      _auth.currentUser.uid, apiToken);
                },
                color: Theme.of(context).accentColor),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addToCart(selectedProduct.id, selectedProduct.title,
                    selectedProduct.price);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  duration: Duration(seconds: 2),
                  content: Text("Added item to the cart"),
                  action: SnackBarAction(
                    label: "UNDO",
                    textColor: Colors.black87,
                    onPressed: () {
                      cart.removeSingleItem(selectedProduct.id);
                    },
                  ),
                ));
              },
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
