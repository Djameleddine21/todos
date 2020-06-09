import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  TodoItem({@required this.todo}) : assert(todo != null);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        title: Text(widget.todo.title),
        subtitle: Text(
          widget.todo.description,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(widget.todo.dateTime.toString().substring(0, 10)),
        leading: widget.todo.isDone
            ? Icon(Icons.check_box, color: greenColor)
            : Icon(Icons.check_box_outline_blank, color: greenColor),
      ),
    );
  }
}
