import 'package:entity_persistence/data/data_sources/local/database_provider.dart';
import 'package:entity_persistence/data/data_sources/local/database_provider_sqlite.dart';
import 'package:entity_persistence/data/persistence/configuration.dart';
import 'package:entity_persistence/data/persistence/entity_manager.dart';
import 'package:entity_persistence/data/persistence/entity_manager_factory.dart';
import 'package:entity_persistence/data/persistence/persistence_manager.dart';

class EntityManagerFactoryImpl extends EntityManagerFactory {
  late DatabaseProvider provider;
  late Configuration configuration;

  EntityManagerFactoryImpl(this.configuration);

  @override
  Future<EntityManager> createEntityManager() async {
    String providerName = configuration["provider"];
    provider = switch (providerName) {
      'mysql' => DatabaseProviderSQLite(configuration),
      'sqlite' => DatabaseProviderSQLite(configuration),
      'sqlserver' || 'jdbc:sqlserver' => DatabaseProviderSQLite(configuration),
      'postgresql' || 'postgres' => DatabaseProviderSQLite(configuration),
      _ => throw ArgumentError.value(provider, 'provider',
          'Invalid provider type, must be one of: ${ProviderType.values.join(', ')}.'),
    };
    await provider.open();
    return provider.createEntityManager();
  }

  @override
  Future<void> close() {
    throw UnimplementedError();
  }
}
