import 'package:e_shop/screens/product_overview-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E Shop",
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.red,
        fontFamily: "Oxygen",
      ),
      home: ProductOverviewScreen(),
    );
  }
}
