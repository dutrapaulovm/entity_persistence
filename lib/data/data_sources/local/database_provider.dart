import 'package:entity_persistence/data/persistence/entity_manager.dart';

abstract class DatabaseProvider {
  Future<void> open();

  Future<void> clear();

  ///Makes all changes made since the previous commit/rollback permanent
  ///and releases any database locks currently held by this DatabaseProvider object.
  Future<void> commit();

  Future<void> rollback();

  Future<void> beginTransaction();

  // close database connection
  Future<void> close();

  bool get isOpen;

  void checkDatabaseConnection();

  EntityManager createEntityManager();
}
