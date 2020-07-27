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
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  //total amount in the cart
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  //remove a single item from cart
  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  //clear cart
  void clearCart() {
    _items = {};
    notifyListeners();
  }

  //remove a single item or one quantity from the cart
  void removeSingleItem(String cartId) {
    if (!_items.containsKey(cartId)) {
      return;
    }
    if (_items[cartId].quantity > 1) {
      _items.update(
          cartId,
          (exisitingCartItem) => CartItem(
              id: exisitingCartItem.id,
              title: exisitingCartItem.title,
              price: exisitingCartItem.price,
              quantity: exisitingCartItem.quantity - 1));
    } else {
      _items.remove(cartId);
    }
    notifyListeners();
  }
}
