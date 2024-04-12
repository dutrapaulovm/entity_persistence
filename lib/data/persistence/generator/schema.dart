import 'package:entity_persistence/data/persistence/generator/table.dart';

abstract class Schema {
  void create(String tableName, void Function(Table table) callback);
  Future<dynamic> run();
  Future<String> toSql();
}
