import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meal_deatails_screen.dart';
import 'package:meals_app/Screens/tabs_screen.dart';
import 'package:meals_app/models/meal.dart';
import '../Screens/category_meals_screen.dart';
import 'Screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //Tab Bar theme
        tabBarTheme: const TabBarTheme(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.amber))),
        //background theme
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        //main colors in app
        colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.amber, primarySwatch: Colors.teal),
        //fonts used in app
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
              subtitle2: const TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailsScreen.routeName: (ctx) => const MealDetailsScreen(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => const CategoriesScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Meal> favoritesMeals = [];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal App',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
