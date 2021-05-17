DeliMeals

A Meals recipies guide app.
The data is located in a local dart file, so there is no backend.

## Following the Flutter Course in Udemy

This project was developed following the 4th section of the ["Flutter & Dart - The Complete Guide [2021 Edition]"](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)

### Some contents learned in this section


- Navigation basics
<br/>-> "Screens" (or "Routes, "Pages") are just widgets. Widgets that you use to control the entire page, or, at least a significant part of it.
<br/>-> Flutter Navigator allow you to switch between pages. push() to add a page to the stack, pop() to substract the last page of the stack, and replace() to delete the last one and push one.
<br/>-> You can use named routes or unnamed routes.
- Passing data between pages
<br/>-> Data can be passed between pages via arguments (directly) or via ModalRoute.of(context).settings.arguments when using pushNamed.
<br/>-> Data can be passed back, too (read via Future with the .then() method)
<br/>-> Data can be anithing! (strings, ints, objects, Functions...)
- Tabs
<br/>-> You can add tabs in the AppBar or at the bottom of the page.
<br/>-> Tabs allow you to switch between stacks (no popping)
- Drawers & Dialogs
<br/>-> Drawers (side menus) also allow you to switch between different stacks.
<br/>-> Drawers and other dialogs (models, alerts...) can also be closed via Navigaor.pop().
- GridView
- enums
- Color gradients


