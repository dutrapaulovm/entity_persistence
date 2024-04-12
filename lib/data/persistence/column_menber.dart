// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Classe que representa uma coluna de uma tabela de banco de dados.
class ColumnMember {
  String? name;
  String? alias;
  String? tableName;
  ColumnType type;
  int length = 0;
  bool? isTransient;
  String? property;
  bool isNullable;
  bool isPrimaryKey;
  dynamic defaultValue;

  ColumnMember(
      {this.name,
      this.alias,
      this.tableName,
      this.type = ColumnType.varchar,
      this.length = 255,
      this.isTransient,
      this.isPrimaryKey = false,
      this.property,
      this.isNullable = false,
      this.defaultValue});
}

class ColumnType {
  final String name;

  const ColumnType({
    required this.name,
  });

  //Numner
  static const ColumnType varchar = ColumnType(name: "varchar");
  static const ColumnType int = ColumnType(name: "int");
  static const ColumnType doublePrecision =
      ColumnType(name: "double precision");
  static const ColumnType bigInt = ColumnType(name: 'bigint');
  static const ColumnType smallInt = ColumnType(name: 'smallint');
  static const ColumnType tinyInt = ColumnType(name: 'tinyint');
  static const ColumnType bit = ColumnType(name: 'bit');
}
