import 'package:todos/models/todo.dart';

class TodoService {
  /**
   * create Todo item and store it in the Firebase
   */
  Future createTodo(Todo todo) async {}

  /**
   * delete Todo item from the Firebase database
  */
  Future deleteTodo(String id) async {}

  Future updateTodo(String id)async{

  }

  Future<List<Todo>> getTodos(String userId)async{
    return <>[];
  }

}
