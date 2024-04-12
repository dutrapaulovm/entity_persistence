import 'package:entity_persistence/data/persistence/configuration.dart';
import 'package:entity_persistence/data/persistence/entity_manager.dart';
import 'package:entity_persistence/data/persistence/entity_manager_factory.dart';
import 'package:entity_persistence/data/persistence/entity_manager_factory_impl.dart';

enum ProviderType {
  mysql,
  sqlite,
  postgresql, // postgres | postgresql
  sqlserver; // sqlserver | jdbc:sqlserver

  static ProviderType of(String name) {
    return switch (name) {
      'mysql' => ProviderType.mysql,
      'sqlite' => ProviderType.sqlite,
      'sqlserver' || 'jdbc:sqlserver' => ProviderType.sqlserver,
      'postgresql' || 'postgres' => ProviderType.postgresql,
      _ => throw ArgumentError.value(name, 'name',
          'Invalid provider type, must be one of: ${ProviderType.values.join(', ')}.'),
    };
  }
}

class PersistenceManager {
  static late EntityManagerFactory _entityManagerFactory;
  static late Configuration _configuration;
  PersistenceManager._(); // Construtor privado para evitar instanciação externa

  static Future<void> init({String pathConfig = ""}) async {
    _configuration = await Configuration.open(path: pathConfig);
  }

  static EntityManagerFactory getEntityManagerFactory() {
    _entityManagerFactory = EntityManagerFactoryImpl(_configuration);
    return _entityManagerFactory;
  }

  static Future<EntityManager> createEntityManager() async {
    getEntityManagerFactory();
    return await _entityManagerFactory.createEntityManager();
  }

  static void closeEntityManagerFactory() {
    _entityManagerFactory.close();
  }
}
