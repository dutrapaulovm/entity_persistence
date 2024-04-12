import 'package:entity_persistence/data/data_sources/local/database_provider_sqlite.dart';
import 'package:entity_persistence/data/persistence/generator/database_schema.dart';
import 'package:entity_persistence/data/persistence/generator/table.dart';

class SQLiteSchema extends DatabaseSchema {
  final List<Table> _tables = [];
  DatabaseProviderSQLite provider;

  SQLiteSchema(this.provider);

  @override
  void create(String tableName, void Function(Table table) callback) {
    StringBuffer buffer = StringBuffer();
    var table = Table();
    _tables.add(table);
    callback(table);

    buffer
      ..write('CREATE TABLE ${table.name} (')
      ..writeln()
      ..writeln(');');
  }

  @override
  Future<dynamic> run() async {
    return await provider.getDatabase.transaction((txn) async {
      var result = await provider.getDatabase.rawQuery("");
      return result;
    });
  }

  @override
  Future<String> toSql() {
    StringBuffer buffer = StringBuffer();
    for (var table in _tables) {}
    throw UnimplementedError();
  }
}
