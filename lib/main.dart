import 'package:flutter/material.dart';
import 'package:todos/routes/routes.dart';
import 'package:todos/screens/home/home_page.dart';

void main()=> runApp(Todos());

class Todos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todos",
      onGenerateRoute: Router.generateRoute,
      initialRoute: HomePage.id,
    );
  }
}