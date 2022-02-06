import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/meal_item.dart';
import '../main.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final appBarColor = Theme.of(context).colorScheme.primary;
    return favoritesMeals.isEmpty
        ? Center(
            child: Text(
              'You Have no favorite Meals',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        : ListView.builder(
            itemCount: favoritesMeals.length,
            itemBuilder: (build, index) {
              return Card(
                margin: const EdgeInsets.all(4),
                elevation: 0,
                color: const Color.fromRGBO(255, 254, 229, 1),
                child: MealItem(
                    id: favoritesMeals[index].id,
                    appbarColor: appBarColor,
                    title: favoritesMeals[index].title,
                    imageUrl: favoritesMeals[index].imageUrl,
                    duration: favoritesMeals[index].duration,
                    complexity: favoritesMeals[index].complexity,
                    affordability: favoritesMeals[index].affordability),
              );
            });
  }
}
