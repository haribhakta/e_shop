import './provider/cart_provider.dart';
import './screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/products_provider.dart';
import './screens/product_details_screen.dart';
import './screens/cart_screen.dart';
import './provider/order_provider.dart';
import './screens/order_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_product_screen.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './provider/auth_provider.dart';

Future<void> main() async {
  // widgets initialize
  WidgetsFlutterBinding.ensureInitialized();
  //firebase app initialize
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Products>(
            update: (context, AuthProvider auth, Products previousProducts) {
              return Products(auth.authToken, auth.userId,
                  previousProducts == null ? [] : previousProducts.items);
            }),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Shop',
            theme: ThemeData(
                primaryColor: Colors.green,
                accentColor: Colors.red,
                fontFamily: "Lato"),
            home: auth.userId == null ? AuthScreen() : ProductOverviewScreen(),
            routes: {
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen()
            },
          );

        },
      ),
    );
  }
}
