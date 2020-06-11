import 'package:flutter/material.dart';
import 'package:todos/screens/home/widgets/todo_item.dart';
import 'package:todos/services/todo_service.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query != "") {
            query = "";
          } else {
            Navigator.pop(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == "") return Container();
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: TodoService.instance.searchTodo(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final todos = snapshot.data;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItem(id: todos[index]["id"], todo: todos[index]["todo"]);
            },
          );
        } else
          return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") return Container();
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: TodoService.instance.searchTodo(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final todos = snapshot.data;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItem(id: todos[index]["id"], todo: todos[index]["todo"]);
            },
          );
        } else
          return Container();
      },
    );
  }
}
