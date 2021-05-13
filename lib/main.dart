import 'screens/category_meals_screen.dart';

import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: CategoriesScreen(),
      //  initialRoute: '/', por defecto, la ruta inicial de la app ya es '/'. podemos cambiarla.
      routes: {
        //  '/': (ctx) => CategoriesScreen(), por defecto, la ruta '/' está definida automáticamente con el campo 'home'.
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
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
