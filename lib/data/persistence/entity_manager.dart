import 'package:entity_persistence/data/persistence/generator/database_schema.dart';
import 'package:entity_persistence/data/persistence/entity.dart';
import 'package:entity_persistence/data/persistence/entity_transaction.dart';

abstract class EntityManager<T extends Entity> {
  Future<T> persist(T entity);
  Future<List<Entity>> persistAll(List<T> entities);
  Future<int> update(T entity);
  Future<List<int>> updateAll(List<T> entities);
  Future<T?> find(T entity, int id);
  Future<int> remove(T entity);
  Future<void> refresh(T entity);
  Future<List<T>> findAllToList(T entity);
  Future<DatabaseSchema> getSchema();
  Future<List<Map<String, dynamic>>> findAllMap(Entity entity);
  EntityTransaction getTransaction();
  Future<List<Map<String, dynamic>>> createNativeQuery(String sql);
  Future<dynamic> transaction(
      Future<dynamic> Function(List<Entity> entities) action);
}
