import 'package:flutter/material.dart';
import 'package:todos/screens/add_todo/add_todo_page.dart';
import 'package:todos/screens/home/widgets/drawer.dart';
import 'package:todos/screens/home/widgets/todo_item.dart';
import 'package:todos/screens/search/search_page.dart';
import 'package:todos/services/auth_service.dart';
import 'package:todos/services/todo_service.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  static const String id = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;
  String userId;

  /// refresh home page by call get all todos items
  Future _refresh() async {
    setState(() {});
  }

  ///get the id of the Current user
  getUserID() async {
    
    userId = await AuthService.instance.getUserId();
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: greenColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            },
          ),
        ],
      ),

      /// drawer
      drawer: CustomDrawer(),

      /// body
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: TodoService.instance.getTodos(),
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
