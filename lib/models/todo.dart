import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.dateTime,
    @required this.isDone,
  })  : assert(title != null),
        assert(description != null),
        assert(dateTime != null),
        assert(isDone != null);

  /// generate fromJson & toJson with Json serialization

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
