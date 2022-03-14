import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Shop APP'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routename);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductsScreen.routename);
            },
          ),
        ],
      ),
    );
  }
}
