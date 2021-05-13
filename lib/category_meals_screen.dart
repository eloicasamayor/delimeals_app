import 'package:flutter/material.dart';
import './dummy_data.dart';

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
    final categoryTitle = routeArguments['title'];
    final categoryId = routeArguments['id'];
    // Tenemos que filtrar los meals que contengan la categoria seleccionada.
    // Para ello, usamos el método .where sobre la lista DUMMY_MEALS. Nos retornará un iterable, que convertimos a lista con el toList()
    // para cada meal, se incluirá o no en la nueva lista si cumple con la condición.
    // en este caso, la condicion es que su lista de categorias contenga la "categoria seleccionada" (categoryId)
    // para esto, usamos el método de List llamado .contains, el cual nos devuelve true / false si la lista contiene el elemento que le pasamos como parámetro.
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    // ahora, categoryMeals será nuestra lista de meals de esa categoría
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text(
            categoryMeals[index].title,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
