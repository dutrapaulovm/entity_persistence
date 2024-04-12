import 'package:entity_persistence/exceptions.dart';

///Verifica se o objeto é do tipo Bundle
///[object] Tipo a ser verificado
bool isBundle(dynamic object) {
  bool result = object is Bundle;
  if (!result) {
    throw ApplicationException(null, message: "Type isn't a Bundle");
  }
  return result;
}

///Classe utilizada para armazenar informações sobre os parâmetros enviados entre as janlas
class Bundle {
  final Map<dynamic, dynamic> _arguments = {};

  void put(dynamic key, dynamic value) {
    _arguments[key] = value;
  }

  dynamic operator [](String key) => _arguments[key];

  operator []=(String key, dynamic value) {
    _arguments[key] = value;
  }

  dynamic get(String key) {
    if (_arguments.containsKey(key)) {
      return _arguments[key];
    } else {
      throw ArgumentError('Invalid Key: $key');
    }
  }

  bool contaisKey(Object? key) {
    return _arguments.containsKey(key);
  }
}
