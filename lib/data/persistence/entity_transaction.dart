/// Interface used to control transactions on resource-local entity
/// managers. The [EntityManager.getTransaction] method returns the
/// [EntityTransaction] interface.
///
/// @since Dart Persistence 1.0
///
abstract class EntityTransaction{
  
  /// Start a resource transaction.
  ///
  /// Throws an [IllegalStateException] if [isActive] is true.
  void begin();

  /// Commit the current resource transaction, writing any
  /// unflushed changes to the database.
  ///
  /// Throws an [IllegalStateException] if [isActive] is false.
  /// Throws a [RollbackException] if the commit fails.
  void commit();

  /// Roll back the current resource transaction.
  ///
  /// Throws an [IllegalStateException] if [isActive] is false.
  /// Throws a [PersistenceException] if an unexpected error
  /// condition is encountered.
  void rollback();

  /// Mark the current resource transaction so that the only
  /// possible outcome of the transaction is for the transaction
  /// to be rolled back.
  ///
  /// Throws an [IllegalStateException] if [isActive] is false.
  void setRollbackOnly();

  /// Determine whether the current resource transaction has been
  /// marked for rollback.
  ///
  /// Returns a boolean indicating whether the transaction has been
  /// marked for rollback.
  ///
  /// Throws an [IllegalStateException] if [isActive] is false.
  bool getRollbackOnly();

  /// Indicate whether a resource transaction is in progress.
  ///
  /// Returns a boolean indicating whether transaction is
  /// in progress.
  ///
  /// Throws a [PersistenceException] if an unexpected error
  /// condition is encountered.
  bool isActive();

}