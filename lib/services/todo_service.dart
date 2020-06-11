import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/screens/home/home_page.dart';
import 'package:todos/services/auth_service.dart';

class TodoService {
  final String _collection = "todos";

  Firestore _firestore;

  /// unique instance for this class
  static TodoService instance = TodoService._();

  /// private constroctor
  /// for Singleton pattren
  TodoService._() {
    _firestore = Firestore.instance;
  }

  /// create Todo item and store it in the Firebase
  Future createTodo(Todo todo, BuildContext context) async {
    try {
      _showWaiting(context);
      await _firestore.collection(_collection).add(todo.toJson());
      Navigator.popAndPushNamed(context,HomePage.id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///  delete Todo item from the Firebase database
  Future deleteTodo(String id) async {
    try {
      await _firestore.collection(_collection).document(id).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///update Todo item
  Future updateTodo(Todo todo) async {
    try {
      await _firestore
          .collection(_collection)
          .document(todo.userId)
          .updateData(todo.toJson())
          .then((value) {
        print("Update with succes");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///make todo as Done
  Future doneTodo(String id, bool isDone) async {
    try {
      await _firestore.collection(_collection).document(id).updateData({"isDone": (!isDone)});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// get All todo Item of the user
  /// as List of Map with todo id as key and the todo object as value
  Future<List<Map<String, dynamic>>> getTodos() async {
    String userId = await AuthService.instance.getUserId();
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    try {
      QuerySnapshot data = await _firestore
          .collection(_collection)
          .where("user_id", isEqualTo: userId)
          .getDocuments();
      data.documents.forEach((element) {
        // map.putIfAbsent(element.documentID, () => Todo.fromJson(element.data));
        list.add({
          "id": element.documentID,
          "todo": Todo.fromJson(element.data),
        });
      });
      return list;
    } catch (e) {
      print(e.toString());
    }
    return list;
  }

  ///Search a todo item with title
  Future<List<Map<String, dynamic>>> searchTodo(String title) async {
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    try {
      QuerySnapshot data = await _firestore
          .collection(_collection)
          .where("title", isGreaterThanOrEqualTo: title)
          .getDocuments();
      data.documents.forEach((element) {
        // map.putIfAbsent(element.documentID, () => Todo.fromJson(element.data));
        list.add({
          "id": element.documentID,
          "todo": Todo.fromJson(element.data),
        });
      });
      return list;
    } catch (e) {
      print(e.toString());
    }
    return list;
  }

  /// show alert dialog of waiting
  _showWaiting(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Wait..."),
            content: Container(
              height: 100.0,
              width: 100.0,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
