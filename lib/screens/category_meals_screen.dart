import 'package:delimeals/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // para evitar errores en los errores de las rutas a las páginas, es común
  // crear una variable static const para acceder a ella desde main.dart.
  static const routeName = '/category-meals';
  //final String categoryId;
  //final String categoryTitle;

  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
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
    final categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    // ahora, categoryMeals será nuestra lista de meals de esa categoría
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
