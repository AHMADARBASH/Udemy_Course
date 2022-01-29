import 'package:flutter/material.dart';
import 'dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/CategoryMeals';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle.toString(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return Text(
              categoryMeals[index].title,
              style: Theme.of(context).textTheme.subtitle1,
            );
          }),
    );
  }
}
