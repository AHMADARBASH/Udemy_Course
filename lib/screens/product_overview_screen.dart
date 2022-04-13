import 'package:flutter/material.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:badges/badges.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';

enum FavoriteFilter {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isLoading = false;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchandSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
          actions: [
            PopupMenuButton(
              onSelected: (FavoriteFilter selectedvalue) {
                setState(() {
                  if (selectedvalue == FavoriteFilter.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert_sharp),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    'My Favorites',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  value: FavoriteFilter.favorites,
                ),
                PopupMenuItem(
                  child: Text(
                    'All Items',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  value: FavoriteFilter.all,
                )
              ],
            ),
            Consumer<Cart>(
              builder: (context, cart, ch) => Badge(
                position: BadgePosition.topEnd(end: 0, top: 0),
                animationType: BadgeAnimationType.slide,
                animationDuration: const Duration(milliseconds: 500),
                child: ch!,
                badgeColor: Theme.of(context).colorScheme.secondary,
                badgeContent: Text(
                  cart.itemCount.toString(),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routename);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ProductsGrid(_showOnlyFavorites),
        drawer: AppDrawer(),
      ),
    );
  }
}
