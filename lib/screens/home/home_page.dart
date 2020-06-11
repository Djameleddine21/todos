
import 'package:flutter/material.dart';
import 'package:todos/screens/add_todo/add_todo_page.dart';
import 'package:todos/screens/home/widgets/todo_item.dart';
import 'package:todos/services/todo_service.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  static const String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;

  /// refresh home page by call get all todos items
  Future _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"), centerTitle: true, backgroundColor: greenColor),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: TodoService.instance.getTodos("ZhptkGKsdld1ybJ2HHDkzaPzWbE2"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final todos = snapshot.data;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(id: todos[index]["id"], todo: todos[index]["todo"]);
                },
              );
            } else
              return Text("Something wrong", textAlign: TextAlign.center);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddTodoPage.id),
        child: Icon(Icons.add, color: Colors.white, size: 35.0),
        backgroundColor: greenColor,
      ),
    );
  }
}
