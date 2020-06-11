// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    userId: json['user_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    dateTime: json['dateTime'] as String,
    isDone: json['isDone'] as bool,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime,
      'isDone': instance.isDone,
    };
