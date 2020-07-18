import 'package:e_shop/models/product.dart';
import 'package:e_shop/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
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
                onPressed: () {
                  product.toogleFavourite();
                },
                color: Theme.of(context).accentColor),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addToCart(selectedProduct.id, selectedProduct.title,
                    selectedProduct.price);
              },
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
