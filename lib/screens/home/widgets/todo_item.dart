import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/todo_service.dart';
import '../../../constants.dart';

class TodoItem extends StatefulWidget {
  final String id;
  final Todo todo;

  TodoItem({@required this.todo, @required this.id})
      : assert(todo != null),
        assert(id != null);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    // genertae Key widget of Dissmisble and make sur that the key is unique with 2 random numbers
    final Key keyWidegt = Key(widget.todo.title +
        Random().nextInt(1000).toString() +
        Random().nextInt(100).toString());
    //
    return Dismissible(
      key: keyWidegt,
      direction: DismissDirection.endToStart,
      dismissThresholds: {DismissDirection.endToStart: 0.95},
      onDismissed: (_) {
        TodoService.instance.deleteTodo(widget.id);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10.0),
        child: Icon(Icons.delete, color: Colors.white, size: 30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          title: Text(widget.todo.title),
          subtitle: Text(
            widget.todo.description,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(widget.todo.dateTime.toString().substring(0, 16)),
          leading: widget.todo.isDone
              ? Icon(Icons.check_box, color: greenColor)
              : Icon(Icons.check_box_outline_blank, color: greenColor),
          onTap: () {
            this.setState(() {
              TodoService.instance.doneTodo(widget.id, widget.todo.isDone);
              widget.todo.isDone = !widget.todo.isDone;
            });
          },
        ),
      ),
    );
  }
}
