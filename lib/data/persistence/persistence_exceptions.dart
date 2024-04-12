import 'package:entity_persistence/exceptions.dart';

/// Thrown by the persistence provider when a problem occurs.
class PersistenceException extends ApplicationException {
  PersistenceException(Exception exception, {String? message})
      : super(exception, message: message);
}
