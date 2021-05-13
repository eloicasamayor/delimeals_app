import './category_meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  //En general, para las apps, la navegacion entre páginas funciona como en un espacio 3D
  // cuando vamos a una nueva página, se agrega un nuevo elemento en la lista, y el último elemento es el que se ve.
  // push() -> añadimos una página
  // pop() -> quitamos la última página
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoryMealsScreen(id, title);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // InkWell es un widget que es un gestureDetector que tambien lanza un feedback visual de material.dart
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // si agregamos "const" antes del EdgeInsets, Flutter no ejecutará el método con cada build.
        // Eso se puede usar cuando nunca va a cambiar
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
