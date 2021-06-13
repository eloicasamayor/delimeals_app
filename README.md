DeliMeals

A Meals recipies guide app.
The data is located in a local dart file, so there is no backend.

## Following the Flutter Course in Udemy

This project was developed following the 4th section of the ["Flutter & Dart - The Complete Guide [2021 Edition]"](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)

## Navigation
Navigator is a flutter class that helps us to move betwen screens. Like other classes, it needs to be connected with the context.
In mobile apps, pages are managed as a stack. The user see the top-most page, so the last page added to the stack.
- We **push()** a page into the stack so it is the top-most page and it is visible
- We **pop()** to go back to the previous page.

### Flutter Screens
Every widget we want to use as a screen should be wrapped with a **Scaffold** widget so we can configure an appbar and some screen features.

### Main screen of the app
In the MaterialApp widget we define the first screen should be open in the app with **the "home" argument**. There we instantiate the class of the entry point of the app, the root screen.
The "home" screen gets automatically the route path "/". We could change that by setting another path in the "initialRoute" argument.

## Pushing a screen
There are several methods to go to a different place:

### push()
In the push route we pass an instance of MaterialPageRoute (or CuppertinoPageRoute). This takes:
- builder: to define wich widget should be built
- fullscreenDialog: bool to have the default animation and back arrow in the appbar or have an overlay animation and a cross to close the screen.
- settings
With this method, we can pass data to the new screen via the arguments of the constructor of the new screen

```dart
Navigator.of(context).push(MaterialPageRoute(
    builder: (_){
        return CategoryMealsScreen(id, title),
    },
  ),
);
```
### pushNamed()
For complex apps with various screens, there is a more convenient way to define and push screens.
In the MaterialApp we can define a table of routes to use in all the app. This table is in fact a map with srting identifiers of routes and a builder method that returns the screen widget:
```dart
routes: {
    '/category-meals': (ctx) => CategoryMealsScreen(),
}
```
With this, we can use the pushedNamed method, that takes the configured path. We can send arguments also. It can be any object, we can send multiple objects with a map.
```dart
Navigator.of(context).pushNamed('/category-meals', arguments: {'id': id, 'title': title,});
```
To extract the data in the newly pushed screen, we do it inside the build method by using the settings.arguments property of the ModalRoute class.
```dart
final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
final categoryTitle = routeArgs['title'];
final categoryId = routeArgs['id'];
```
To avoid typo errors, a common practise is defining the path of every screen in a static constant property in every screen and use a reference to it instead o typing the path every time:
```dart
// in the CategoryMealsScreen class:
static const routeName = '/category-meals';
// in materialApp to define the path
routes: {
    CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
}
```
In the materialApp class we can define two arguments to avoid routing errors:
- **onGenerateRoute**: we provide a function that returns a screen widget. This will run in case we are going pushNamed route that is not defined in the routes table.
```dart
onGenerateRoute: (settings) {
    print(settings.name){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen();)
    }
}
```
- **onUnknownRoute** is the same as onGenerate but it triggers when flutter fails to load a screen in all other methods. It's good to use it to avoid an state where the app crashes. It's like the 404 error on the web.

### pushReplacement()
We add the new page in the stack but we remove the page below it. So we still have one page in the stack and we won't be able to go back.

## Tabs
### Tabs at the top (below the appBar)
We don't need a Statefulwidget.
We create a **DefaultTabController** with a Scaffold as child. The appBar of that Scaffold can have a bottom argument, in where we put the **Tab()** widgets. As a body, in the scaffold we create a **TabBarView()** with as children as tabs we have.
The DefaultTabController will relate each tab with each tabBarView child and will switch the tab to show the widget. The order of the tabs should match the order of the TabBarView child widgets.

```dart
DefaultTabController(
    lenght:2,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Meals'),
            bottom: TabBar(
                tabs: [
                    Tab(icon: Icon(Icons.category), text: 'Categories',),
                    Tab(icon: Icon(Icons.star), text: 'Favorites',),
                ]
            )
        ), 
        body: TabBarView(
            CategoriesScreen(),
            FavoritesScreen(),
            ),
    )
)
```
### Tabs at the bottom of the screen
We need a Statefulwidget.
We use a normal Scaffold.
We add a bottomNavigationBar argument wich takes a bottomNavigationBar widget. For this widget we should provide:
- items: a list for the tabs. They are BottomNavigationBarItem() widgets and typically we assign them an icon and a title.
- onTap: we provide a method that will receive automatically the index of the selected tab. In that method we have to manage the displayed screen depending on the _selectedPageIndex provided by the onTap method o the botomNavigationBar()
- currentIndex: the variable that updates for the index of the selected tab.
```dart
// in the _TabsScreenState
final List <Widget> _pages = [
    CategoriesScreen(),
    FavoritesScreen(),
];
int _selectedPageIndex = 0;
void _selectPage(int index) {
    setState((){
        _selectedPageIndex = index;
    })
}
// in the build method..
Scaffold(
    appBar: //...
    body: _pages[_selectedPageIndex],
    bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        background: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
            BottomNavigationBarItem(
                icon: Icons(Icons.category),
                title: Text('categories'),
            ),
            BottomNavigationBarItem(
                icon: Icons(Icons.star),
                title: Text('favorites'),
            ),
        ],
    ),
)
```



### InkWell
To make a widget tapable we can use the GestureDetector widget to fire the onTap event. But we can also use a InkWell, wich is a GestureDetector with a "ripple effect" a Material animation that are like waves coming from the tap.
```dart
InkWell(
    onTap: (){},
    splashColor: Theme.of(context).primaryColor,
    borderRatius: BorderRadius.circular(15),
    child: Container(),
)
```
### Gradients
LinearGradient class provide an easy way of creating a nice color gradient:
```dart
BoxDecoration(
    gradient: LinearGradient(
        colors: [ // list of colors between we want to transition
            color.withOpacity(0.7),
            color,
        ],
        begin: Alignment.topLeft, //coordinates where the gradient should start
        end: Alignment.bottomRight, //coordinates where the gradient should end
    )
)
```
## Other concepts
- Tabs
<br/>-> You can add tabs in the AppBar or at the bottom of the page.
<br/>-> Tabs allow you to switch between stacks (no popping)
- Drawers & Dialogs
<br/>-> Drawers (side menus) also allow you to switch between different stacks.
<br/>-> Drawers and other dialogs (models, alerts...) can also be closed via Navigaor.pop().
- GridView
- enums


