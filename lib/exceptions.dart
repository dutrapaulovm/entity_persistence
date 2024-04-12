/// Exception base para todos os exceptions da aplicação e para ocorrência de erros
/// gerais ocorridas na aplicação
class ApplicationException implements Exception {
  final Exception? _exception;
  late String? _message;

  ApplicationException(this._exception, {String? message}) {
    _message = message;
  }

  @override
  String toString() {
    if (_message != null) {
      return _message.toString();
    } else {
      return _exception.toString();
    }
  }

  String error() => toString();
}
