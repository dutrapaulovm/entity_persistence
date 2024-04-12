import 'dart:io';
import 'package:entity_persistence/data/data_sources/local/connection.dart';
import 'package:entity_persistence/data/data_sources/local/database_provider.dart';
import 'package:entity_persistence/data/persistence/configuration.dart';
import 'package:entity_persistence/data/persistence/entity.dart';
import 'package:entity_persistence/data/persistence/entity_manager.dart';
import 'package:entity_persistence/data/persistence/entity_manager_sqlite.dart';
import 'package:entity_persistence/entity_persistence.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DatabaseProviderSQLite extends DatabaseProvider implements Connection {
  late Database _database;
  late Configuration configuration;
  int? _version;
  String? _sql;
  String? _pathDatabase;
  String? _databaseName;

  DatabaseProviderSQLite(this.configuration);

  @override
  Future<void> open() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      //WidgetsFlutterBinding.ensureInitialized();
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
      // this step, it will use the sqlite version available on the system.
      databaseFactory = databaseFactoryFfi;
    }

    String databasePath = await getDatabasesPath();
    Map<String, dynamic> pro =
        configuration.getConfig(Configuration.provider, SQLiteDialect.provider);

    _databaseName = pro[Configuration.database]!;
    _version = int.tryParse(pro[Configuration.version].toString())!;
    _sql = pro[Configuration.sql]!;

    String dbPath = path.join(databasePath, _databaseName);

    _database = await openDatabase(dbPath, version: _version,
        onCreate: (db, version) async {
      if (_sql != null) {
        await db.execute(_sql!);
      } else {
        throw ArgumentError("SQL not found!");
      }
    }, onConfigure: _onConfigure);
  }

  Future<void> _onConfigure(Database db) async {
    // Verifica a versão atual do banco de dados
    var version = await db.getVersion();

    //if (version != DatabaseConfig.version) {
    // Atualize o banco de dados conforme necessário
    if (version >= 1) {
      // Excluir todas as tabelas existentes
      List<Map<String, Object?>> results = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
      for (var element in results) {
        // Consultando o esquema da tabela
        String name = element["name"].toString();
        await db.execute('DROP TABLE IF EXISTS $name;');
      }
      if (_sql != null) {
        await db.execute(_sql!);
      } else {
        throw ArgumentError("SQL not found!");
      }
    }

    // Atualize a versão do banco de dados
    await db.setVersion(configuration[Configuration.version]);
    //}
  }

  Database get getDatabase => _database;

  @override
  Future<void> clear() async {
    await deleteDatabase(path.join(await getDatabasesPath(), _databaseName));
  }

  // close database connection
  @override
  Future<void> close() async {
    checkDatabaseConnection();
    await _database.close();
  }

  @override
  bool get isOpen => _database.isOpen;

  @override
  void checkDatabaseConnection() {
    if (!_database.isOpen) {
      throw Exception('No open connection to database');
    }
  }

  @override
  Future<void> commit() async {
    throw UnimplementedError();
  }

  @override
  Future<void> rollback() async {
    throw UnimplementedError();
  }

  @override
  Future<void> beginTransaction() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isClosed() async {
    return isOpen;
  }

  @override
  EntityManager<Entity> createEntityManager() {
    return EntityManagerSQlite(database: this);
  }

  /*ClienteRepository createClienteRepository() {
    RepositoryFactory provider = DatabaseProviderSQLite.getInstance();
    return ClienteRepositorySQLite(
        database: provider as DatabaseProviderSQLite);
  }*/

  /*static RepositoryFactory getInstance() {
    _dataprovider ??= DatabaseProviderSQLite();
    return _dataprovider;
  }*/
}
