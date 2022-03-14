import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../Providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routename = '/UserProductScreen';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProdcutScreen.routename);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                        id: productsData[i].id,
                        title: productsData[i].title,
                        imageUrl: productsData[i].imageUrl,
                      ),
                      const Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}
