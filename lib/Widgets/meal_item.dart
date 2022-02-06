import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meal_deatails_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final Color appbarColor;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    required this.id,
    required this.appbarColor,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });
  String? get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';

      case Complexity.Hard:
        return 'Hard';

      case Complexity.Challenging:
        return 'Challenging';

      default:
        return 'Unkown';
    }
  }

  String? get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Afforadble';

      case Affordability.Pricey:
        return 'Pricey';

      case Affordability.Luxurious:
        return 'Luxurious';

      default:
        return 'Unkown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailsScreen.routeName,
        arguments: {'id': id, 'AppBarcolor': appbarColor, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: MediaQuery.of(context).size.height * 0.36,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )),
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 26, color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: appbarColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '$duration min',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  Row(children: [
                    Icon(
                      Icons.work,
                      color: appbarColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      complexityText!,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ]),
                  Row(children: [
                    Icon(
                      Icons.attach_money,
                      color: appbarColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      affordabilityText!,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
