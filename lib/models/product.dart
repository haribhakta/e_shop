import 'package:flutter/material.dart';
import 'dart:convert';
import '../helper/API.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageURL;
  bool isFavourite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.imageURL,
      this.isFavourite = false});

  // change the user's favourites status
  Future<void> toggleFavourite(String userId, String authToken) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = API.toggleFavourite + "$userId/$id.json?auth=$authToken";
    print(url);
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      print(response.body);
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
