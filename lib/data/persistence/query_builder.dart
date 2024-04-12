// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:entity_persistence/data/persistence/column_menber.dart';
import 'package:entity_persistence/data/persistence/entity.dart';
import 'package:entity_persistence/data/persistence/sql_utils.dart';

class QueryBuilder {
  String? tableAlias;
  final List<ColumnMember> _columns = [];
  bool isDistinct = false;
  Entity entity;

  QueryBuilder({required this.entity, tableAlias = ""});

  QueryBuilder addColumn(List<String> names) {
    throw UnimplementedError();
  }

  QueryBuilder addColumnFromColumnMember(ColumnMember column) {
    columns.add(column);
    return this;
  }

  String toSQLString() {
    StringBuffer buffer = StringBuffer();
    buffer.write("SELECT ");
    buffer.write(SQLUtils.builderColumnsSelectFromMap(entity, entity.toMap()));
    if (isDistinct) buffer.write(" DISTINCT ");
    buffer.write(" FROM ");
    buffer.write(entity.entityName);
    if (tableAlias != null) {
      if (tableAlias!.isNotEmpty) {
        buffer.write(" AS ");
        buffer.write(tableAlias);
      }
    }
    return buffer.toString();
  }

  List<ColumnMember> get columns => _columns;
}
