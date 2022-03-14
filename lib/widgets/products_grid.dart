import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productitems = showFavs ? productsData.favs : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: productitems.length,
      itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
        key: Key('item$idx'),
        value: productitems[idx],
        child: ProductItem(),
      ),
    );
  }
}
