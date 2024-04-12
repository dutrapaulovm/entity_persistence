import 'dart:convert';

abstract class Entity {
  String get entityName;

  static String get primaryKey => "ID";

  int? id;

  Entity({this.id});

  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());

  Entity fromMap(Map<String, dynamic> map);
}
