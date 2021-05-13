import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // para evitar errores en los errores de las rutas a las páginas, es común
  // crear una variable static const para acceder a ella desde main.dart.
  static const routeName = '/category-meals';
  //final String categoryId;
  //final String categoryTitle;

  //CategoryMealsScreen(this.categoryId, this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    // cuando se llama a una página mediante el pushNamed, accedemos a los argumentos mediante ModalRoute.of(context).settings.arguments
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final CategoryTitle = routeArguments['title'];
    final CategoryId = routeArguments['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(CategoryTitle),
      ),
      body: Center(
        child: Text(
          'The Recipes for the category',
        ),
      ),
    );
  }
}
