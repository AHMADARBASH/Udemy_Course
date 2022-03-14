import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import './screens/cart_screen.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './Providers/products.dart';
import 'package:provider/provider.dart';
import 'Providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            textTheme: const TextTheme(
                subtitle1: TextStyle(fontSize: 20, color: Colors.black),
                subtitle2: TextStyle(fontSize: 20, color: Colors.white),
                headline5:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.RouteName: (ctx) => ProductDetailScreen(),
          CartScreen.routename: (ctx) => CartScreen(),
          OrdersScreen.routename: (ctx) => const OrdersScreen(),
          UserProductsScreen.routename: (ctx) => const UserProductsScreen(),
          EditProdcutScreen.routename: (ctx) => const EditProdcutScreen(),
        },
      ),
    );
  }
}
