abstract class Connection {
  Future<void> commit();
  Future<void> rollback();
  Future<void> close();
  Future<bool> isClosed();
  bool get isOpen;
}
