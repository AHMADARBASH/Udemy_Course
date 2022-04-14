import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import './screens/splash_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import './screens/cart_screen.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './Providers/products.dart';
import 'package:provider/provider.dart';
import 'Providers/orders.dart';
import './screens/auth-screen.dart';
import './Providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (ctx, auth, products) => Products(auth.token, auth.userID,
              products!.items.isEmpty ? [] : products.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (ctx, auth, orders) => Orders(auth.token, auth.userID,
              orders!.orders.isEmpty ? [] : orders.orders),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
                accentColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(fontSize: 20, color: Colors.black),
                  subtitle2: TextStyle(fontSize: 20, color: Colors.white),
                  headline5:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : AuthScreen()),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductDetailScreen.RouteName: (ctx) => ProductDetailScreen(),
            CartScreen.routename: (ctx) => CartScreen(),
            OrdersScreen.routename: (ctx) => const OrdersScreen(),
            UserProductsScreen.routename: (ctx) => const UserProductsScreen(),
            EditProdcutScreen.routename: (ctx) => const EditProdcutScreen(),
          },
        ),
      ),
    );
  }
}
