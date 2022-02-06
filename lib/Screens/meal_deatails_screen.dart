import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import '../dummy_data.dart';
import 'package:meals_app/main.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = '/MealDetailsScreen';

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //variables
    final mealspecs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealspecs['id']);
    final appbarColor = mealspecs['AppBarcolor'];

    void _addFavoritItem(Meal currentmeal) {
      favoritesMeals.any((element) => element == currentmeal)
          ? favoritesMeals.removeWhere((element) => element == currentmeal)
          : favoritesMeals.add(currentmeal);
    }

    //main widget in screen
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: appbarColor as Color,
        //   onPressed: () {
        //     _addFavoritItem(mealspecs['id'] as String);
        //   },
        //   child: const Icon(Icons.favorite),
        // ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _addFavoritItem(selectedMeal);
                });
              },
              icon:
                  favoritesMeals.any((element) => element.id == mealspecs['id'])
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite,
                          color: Color.fromRGBO(7, 34, 39, 100)),
            ),
          ],
          title: Text(
            '${mealspecs['title']}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          backgroundColor: appbarColor as Color,
        ),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Ingrediants',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 25),
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 3,
              indent: 50,
              endIndent: 50,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Text(
                          '- ${selectedMeal.ingredients[index]}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 25),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Stpes',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 25),
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 3,
              indent: 50,
              endIndent: 50,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: mealspecs['AppBarcolor'] as Color,
                        child: Text(
                          '# ${(index + 1)}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
