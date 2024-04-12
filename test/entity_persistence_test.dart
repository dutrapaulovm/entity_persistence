import 'package:entity_persistence/data/persistence/generator/generator.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:entity_persistence/entity_persistence.dart';

import 'domain/models/usuario.dart';

void main() async {
  //test('Teste persistence', () async {
  await PersistenceManager.init();

  var table = Table();
  table
    ..name = "TESTE"
    ..varchar("teste").defaultValue = "5";

  EntityManager em = await PersistenceManager.createEntityManager();
  em.persist(User(
      name: "Joe Joe",
      login: "joejoe",
      email: "joe@teste.com",
      password: "joe123"));

  QueryBuilder queryBuilder = QueryBuilder(entity: User());
  print(queryBuilder.toSQLString());

  Entity? entity = await em.find(User(), 1);
  if (entity == null) {
    print("Não retornou nada");
  } else {
    print("Retornou: " + entity.toString());
  }
  //DatabaseSchema schema = await em.getSchema();
  //await schema.showTables();
  //});
}
