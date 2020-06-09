import 'package:flutter/material.dart';

class Todo {
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo({
    @required this.title,
    @required this.description,
    @required this.dateTime,
    @required this.isDone,
  })  : assert(title != null),
        assert(description != null),
        assert(dateTime != null),
        assert(isDone != null);
}
