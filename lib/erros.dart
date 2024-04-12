class ApplicationError extends Error {
  final String message;

  ApplicationError(this.message);
  @override
  String toString() => "Bad state: $message";
}

class ColumnDuplicateError extends ApplicationError {
  ColumnDuplicateError(super.message);
}
