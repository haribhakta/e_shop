import '../provider/order_provider.dart' show Orders;
import '../wigdets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wigdets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order_screen";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
