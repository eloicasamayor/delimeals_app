import './dummy_data.dart';
import 'package:flutter/material.dart';
import './category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView, igual que ListView, tiene el método .builder() que no renderiza los elementos de fuera de la pantalla.
    // y que se puede usar cuando no sabes cuántos elementos querrás poner.

    // GridView requiere que le pasamos un parámetro concreto: gridDelegate.
    // gridDelegate es una función que le dice al grid cómo tiene que formatearse.
    // en este caso, SilverGrid Delegate WithMaxCrossAxisExtent nos permite decirle una width máxima y flutter se encargará de crear el grid teniendo esta anchura máxima de las celdas.

    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeal'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
