import 'dart:convert';
import 'dart:io';

import 'package:entity_persistence/exceptions.dart';

class Configuration {
  static const String provider = 'provider';
  static const String host = 'host';
  static const String port = 'port';
  static const String username = 'username';
  static const String password = 'password';
  static const String database = 'database';
  static const String version = 'version';
  static const String sql = 'sql';

  Map<String, dynamic> _properties;

  Configuration(this._properties);

  factory Configuration.fromJson(String jsonStr) =>
      Configuration(json.decode(jsonStr));

  String toJson() => json.encode(_properties);

  dynamic operator [](String key) => _properties[key];

  operator []=(String key, dynamic value) {
    _properties[key] = value;
  }

  dynamic getConfig(String dbName, String configKey) {
    if (_properties.containsKey(dbName)) {
      var dbConfig = _properties["databases"];
      if (dbConfig.containsKey(configKey)) {
        return dbConfig[configKey];
      } else {
        throw ArgumentError('Chave de configuração inválida: $configKey');
      }
    } else {
      throw ArgumentError('Banco de dados não encontrado: $dbName');
    }
  }

  static Future<Configuration> open({String path = ""}) async {
    late Configuration config;
    try {
      late String fileName;
      if (path.isEmpty) {
        fileName = 'config/datasources.json';
      } else {
        fileName = path;
      }

      File file = File(fileName);
      if (file.existsSync()) {
        String contents = file.readAsStringSync();
        config = Configuration.fromJson(contents);
      }

      /*// Certifique-se de que o Flutter esteja inicializado
      WidgetsFlutterBinding.ensureInitialized();
      // Carregar o conteúdo do arquivo JSON
      final String json =
          await rootBundle.loadString('assets/config/datasources.json');*/
    } on Exception catch (e) {
      throw ApplicationException(e,
          message: "Erro ao ler arquivo de configuração");
    }
    return config;
  }
}
