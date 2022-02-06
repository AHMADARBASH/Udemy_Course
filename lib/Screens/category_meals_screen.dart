import 'package:flutter/material.dart';
import '../Widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/CategoryMeals';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final categoryColor = routeArgs['color'];
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: categoryColor as Color,
          title: Text(
            categoryTitle.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        body: ListView.builder(
            itemCount: categoryMeals.length,
            itemBuilder: (ctx, index) {
              return MealItem(
                id: categoryMeals[index].id,
                appbarColor: categoryColor,
                title: categoryMeals[index].title,
                imageUrl: categoryMeals[index].imageUrl,
                duration: categoryMeals[index].duration,
                complexity: categoryMeals[index].complexity,
                affordability: categoryMeals[index].affordability,
              );
            }),
      ),
    );
  }
}
