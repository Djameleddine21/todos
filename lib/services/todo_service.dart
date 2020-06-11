import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos/models/todo.dart';

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
  Future createTodo(Todo todo) async {
    try {
      await _firestore.collection(_collection).add(todo.toJson()).then((value) {
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///  delete Todo item from the Firebase database
  Future deleteTodo(String id) async {
    try {
      await _firestore.collection(_collection).document(id).delete().then((value) {
        print("Item deleted");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///update Todo item
  Future updateTodo(Todo todo) async {
    try {
      await _firestore
          .collection(_collection)
          .document(todo.id)
          .updateData(todo.toJson())
          .then((value) {
        print("Update with succes");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// get All todo Item of the user
  Future<List<Todo>> getTodos(String userId) async {
    List<Todo> todos = <Todo>[];
    try {
      _firestore
          .collection(_collection)
          .where("user_id", isEqualTo: userId)
          .getDocuments()
          .then((documents) {
        documents.documents.forEach((element) {
          todos.add(Todo.fromJson(element.data));
        });
        print("Get all todos : ${documents.documents.length}");
      });
    } catch (e) {
      print(e.toString());
    }
    return todos;
  }
}
