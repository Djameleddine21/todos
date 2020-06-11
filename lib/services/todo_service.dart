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
          .document(todo.userId)
          .updateData(todo.toJson())
          .then((value) {
        print("Update with succes");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///make todo as Done
  Future doneTodo(String id, bool isDone) async {
    await _firestore.collection(_collection).document(id).updateData({"isDone": (!isDone)});
    print("update Done");
  }

  /// get All todo Item of the user
  Future<List<Map<String, dynamic>>> getTodos(String userId) async {
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    try {
      QuerySnapshot data = await _firestore
          .collection(_collection)
          .where("user_id", isEqualTo: userId)
          .getDocuments();
      data.documents.forEach((element) {
        // map.putIfAbsent(element.documentID, () => Todo.fromJson(element.data));
        list.add(
          {
            "id": element.documentID,
            "todo" : Todo.fromJson(element.data),
          }
        );
      });
      return list;
    } catch (e) {
      print(e.toString());
    }
    return list;
  }
}
