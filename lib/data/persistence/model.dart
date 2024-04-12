// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:code_builder/code_builder.dart';

class Model {
  final String name;
  final Iterable<Field> fields;

  Model({required this.name, required this.fields});
}
