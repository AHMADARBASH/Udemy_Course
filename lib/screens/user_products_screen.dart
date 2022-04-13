import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../Providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routename = '/UserProductScreen';
  const UserProductsScreen({Key? key}) : super(key: key);
  Future<void> refreshData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchandSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: refreshData(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.hasData
                        ? RefreshIndicator(
                            onRefresh: () => refreshData(context),
                            child: Consumer<Products>(
                              builder: (ctx, data, _) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListView.builder(
                                    itemCount: data.items.length,
                                    itemBuilder: (_, i) => Column(
                                          children: [
                                            UserProductItem(
                                              id: data.items[i].id,
                                              title: data.items[i].title,
                                              imageUrl: data.items[i].imageUrl,
                                            ),
                                            const Divider(),
                                          ],
                                        )),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'no prodcuts to manage for you',
                              style: TextStyle(fontSize: 24),
                            ),
                          )),
      ),
    );
  }
}
