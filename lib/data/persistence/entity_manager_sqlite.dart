import 'package:entity_persistence/data/data_sources/local/database_provider.dart';
import 'package:entity_persistence/data/data_sources/local/database_provider_sqlite.dart';
import 'package:entity_persistence/data/persistence/generator/database_schema.dart';
import 'package:entity_persistence/data/persistence/entity.dart';
import 'package:entity_persistence/data/persistence/entity_manager.dart';
import 'package:entity_persistence/data/persistence/entity_transaction.dart';
import 'package:entity_persistence/data/persistence/persistence_exceptions.dart';
import 'package:sqflite/sqflite.dart';

class EntityManagerSQlite extends EntityManager {
  late DatabaseProvider database;

  EntityManagerSQlite({
    required this.database,
  });

  @override
  Future<int> update(Entity entity) async {
    int count = 0;
    try {
      await database.open();
      final db = (database as DatabaseProviderSQLite).getDatabase;
      count = await db.update(entity.entityName, entity.toMap(),
          where: '${Entity.primaryKey} = ?', whereArgs: [entity.id]);
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }

    return count;
  }

  @override
  Future<Entity?> find(Entity entity, int id) async {
    Entity? resultEntity;

    try {
      await database.open();
      final Database db = (database as DatabaseProviderSQLite).getDatabase;
      List<Map<String, dynamic>> result = await db.query(entity.entityName,
          where: '${Entity.primaryKey} = ?', whereArgs: [id]);

      if (result.isNotEmpty) {
        List<Entity> e = [];

        for (var element in result) {
          e.add(entity.fromMap(element));
        }

        resultEntity = e[0];
      }
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }

    return resultEntity;
  }

  @override
  Future<Entity> persist(Entity entity) async {
    try {
      await database.open();

      final Database db = (database as DatabaseProviderSQLite).getDatabase;
      int id = await db.insert(entity.entityName, entity.toMap());
      entity.id = id;
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }
    return entity;
  }

  @override
  Future<List<Map<String, dynamic>>> findAllMap(Entity entity) async {
    try {
      await database.open();
      final db = (database as DatabaseProviderSQLite).getDatabase;
      return await db.query(entity.entityName);
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }
  }

  @override
  Future<List<Entity>> findAllToList(Entity entity) async {
    try {
      List<Map<String, dynamic>> result = await findAllMap(entity);
      return List.generate(result.length, (index) {
        return entity.fromMap(result[index]);
      });
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }
  }

  @override
  Future<int> remove(Entity entity) async {
    try {
      await database.open();
      final db = (database as DatabaseProviderSQLite).getDatabase;
      return await db.delete(entity.entityName,
          where: '${Entity.primaryKey} = ?', whereArgs: [entity.id]);
    } on Exception catch (e) {
      throw PersistenceException(e);
    } finally {
      if (database.isOpen) {
        database.close();
      }
    }
  }

  @override
  Future<DatabaseSchema> getSchema() async {
    await database.open();
    Database db = (database as DatabaseProviderSQLite).getDatabase;
    List<Map<String, Object?>> results = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
    List<Map<String, List<Map<String, dynamic>>>> tables = [];

    for (var element in results) {
      // Consultando o esquema da tabela
      String name = element["name"].toString();
      final List<Map<String, dynamic>> columns = await db.rawQuery(
        'PRAGMA table_info($name)',
      );

      Map<String, List<Map<String, dynamic>>> info = {
        element["name"].toString(): columns
      };

      tables.add(info);
    }

    return DatabaseSchema(tables: tables);
  }

  @override
  EntityTransaction getTransaction() {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<dynamic> transaction(
      Future<dynamic> Function(List<Entity> entities) action) async {
    Database db = (database as DatabaseProviderSQLite).getDatabase;
    return await db.transaction((txn) {
      return throw ArgumentError("");
    });
  }

  @override
  Future<void> refresh(Entity entity) async {
    entity = (await find(entity, entity.id!))!;
  }

  @override
  Future<List<Map<String, dynamic>>> createNativeQuery(String sql) async {
    await database.open();
    Database db = (database as DatabaseProviderSQLite).getDatabase;
    List<Map<String, Object?>> results = await db.rawQuery(sql);
    return results;
  }

  @override
  Future<List<Entity>> persistAll(List<Entity> entities) async {
    List<Entity> result = [];
    for (Entity entity in entities) {
      result.add(await persist(entity));
    }
    return result;
  }

  @override
  Future<List<int>> updateAll(List<Entity> entities) async {
    List<int> result = [];
    for (Entity entity in entities) {
      result.add(await update(entity));
    }
    return result;
  }
}
