import '../widgets/main_drawer.dart';

import './favorites_screen.dart';

import './categories_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // El DefaultTabController y el TabBar están conectadas
      // DefaultTabController automáticamente detectará qué tab está seleccionada y mostrará el contenido que toca.
      // Para asignar qué contenido debe mostrar, lo pondremos dentro de un TabBarView() ubicado justo después del AppBar
      // mostrará los elementos hijos de este tabBarView dependiendo del tab seleccionado 1º tab -> 1º elemento del tabBarView, y así
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // los widgets que pasamos como pantallas dentro del tabBarView no deben ser Scaffolds, porque no queremos que se añada otro appBar.
            CategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
  }
}
