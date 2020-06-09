import 'package:flutter/material.dart';
import 'package:todos/screens/add_todo/add_todo_page.dart';
import 'package:todos/screens/home/home_page.dart';
import 'package:todos/screens/login/login_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.id:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HomePage.id:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AddTodoPage.id:
        return MaterialPageRoute(builder: (_) => AddTodoPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
