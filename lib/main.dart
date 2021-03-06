import './screens/tabs_screen.dart';

import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';
import 'screens/category_meals_screen.dart';

import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  //función para agregar o quitar un favorito.
  // dada la id de un meal, lo añadirá si no existe en la lista, o lo quitará si ya está.
  void _toggleFavorite(String mealId) {
    // .indexWhere es un método de List que nos devuelve en qué indice de la lista se cumple cierta condición, o sea cuando la condición nos devuelve true.
    // si nunca se cumple, nos devuelve -1.
    // recorre cada elemento de la lista y va ejecutando una función anónima que le pasamos como parémetro.
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      //si ya existe, lo quitamos
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      //si no existe, lo agregamos
      setState(() {
        // .add() -> método de List para agregar un elemento a la lista
        _favoriteMeals.add(
          // .firstWhere() -> método de List que nos devuelve el primer elemento de la lista que cumple una condición (expresada en una función anónima que le pasamos como aragumento.)
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    // .any() -> método de List que nos devuelve true si se cumple una condición para alguno de los elementos de la lista.
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 52, 52, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 52, 52, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // En el atributo 'home' de MaterialApp indicamos cuál debe ser la pantalla principal.

      // Para pasar la información de favoriteMeals a la pantalla favorites, tenemos que pasarla a tabs_screen y desde ésta, a favorites_screen.
      home: TabsScreen(_favoriteMeals),
      //  initialRoute: '/', por defecto, la ruta inicial de la app ya es '/'. podemos cambiarla.
      routes: {
        //'/': (ctx) => TabsScreen(), por defecto, la ruta '/' está definida automáticamente con el campo 'home'.
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              _toggleFavorite,
              _isMealFavorite,
            ),
        FilterScreen.routeName: (ctx) => FilterScreen(
              _filters,
              _setFilters,
            ),
      },
      //onGenerateRoute se ejecuta si dirigimos a una ruta que no está registrada
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      // es como el 404 de la web, una página que se mostrará cuando no encuentra qué mostrar.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
