import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  //itemcount

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  //add item/ product to the cart
  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    }
    else 
    {
      _items.putIfAbsent(productId, () => 
      CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1
      )
      );

    }
    notifyListeners();
  }
}