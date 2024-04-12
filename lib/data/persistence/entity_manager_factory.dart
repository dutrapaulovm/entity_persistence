import 'package:entity_persistence/data/persistence/entity_manager.dart';

abstract class EntityManagerFactory {
  /// Create a new application-managed `EntityManager`.
  ///
  /// This method returns a new `EntityManager` instance each time
  /// it is invoked.
  /// The `isOpen` method will return true on the returned instance.
  ///
  /// Returns an entity manager instance.
  ///
  Future<EntityManager> createEntityManager();

  Future<void> close();
}
