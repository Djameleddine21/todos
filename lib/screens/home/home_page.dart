import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screens/add_todo/add_todo_page.dart';
import 'package:todos/screens/home/widgets/todo_item.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  static const String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"), centerTitle: true, backgroundColor: greenColor),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10.0),
        children: <Widget>[
          TodoItem(
            todo: Todo(
              title: "Practice Sport",
              description: "Go to the gym",
              isDone: true,
              dateTime: DateTime.parse("2020-05-27 13:27:00"),
            ),
          ),
          TodoItem(
            todo: Todo(
              title: "Practice Sport",
              description: "Go to the gym",
              isDone: false,
              dateTime: DateTime.now(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddTodoPage.id),
        child: Icon(Icons.add, color: Colors.white, size: 35.0),
        backgroundColor: greenColor,
      ),
    );
  }
}
