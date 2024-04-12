import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:entity_persistence/data/persistence/generator/schema.dart';
import 'package:entity_persistence/data/persistence/generator/table.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

final _dartfmt = DartFormatter();

class DatabaseSchema extends Schema {
  List<Map<String, List<Map<String, dynamic>>>>? tables;
  DatabaseSchema({this.tables});

  Future<void> showTables() async {
    for (var element in tables!) {
      Map<String, List<Map<String, dynamic>>> v = element;
      List<Field> attributes = [];
      List<Parameter> parameters = [];
      List<Parameter> methodParameters = [];

      v.forEach((key, value) {
        value.forEach((element) {
          if (element["name"].toString() != "ID") {
            var attribute = Field((f) => f
              ..name = element["name"].toString().toLowerCase()
              //..modifier = FieldModifier.final$
              ..type = refer("String?"));
            attributes.add(attribute);

            parameters.add(Parameter((p) => p
              ..name = element["name"].toString().toLowerCase()
              ..toThis = true
              ..named = true
              ..type = refer('String?')));
          }

          methodParameters.add(Parameter((p) => p
            ..name = element["name"].toString().toLowerCase()
            ..named = true));
        });

        print(createClass(key, attributes, parameters, methodParameters));
      });
    }
  }

  Future<String> createClass(String nameClass, List<Field> attributes,
      List<Parameter> parameters, List<Parameter> methodParameters) async {
    // Definindo os imports necessários
    List<Directive> imports = [
      Directive.import(
          'package:flutter_contas_receber/data/persistence/entity.dart'),
      Directive.import('dart:convert'),
    ];

    // Criando um construtor
    final constructor = Constructor((c) => c
      ..optionalParameters.addAll([
        Parameter((b) => b
          ..name = 'id'
          ..toSuper = true
          ..named = true),
        ...attributes.map((field) => Parameter((b) => b
          ..named = true
          ..toThis = true
          ..name = field.name)),
      ]));
    //..initializers.add(Code('super(id: id)')));

// Definindo o método copyWith
    final copyWithMethod = Method((m) => m
      ..name = 'copyWith'
      ..returns = refer(nameClass)
      ..optionalParameters.addAll(methodParameters)
      /*..optionalParameters.addAll(attributes.map((field) => Parameter((b) => b
        ..name = field.name.toLowerCase()
        ..type = field.type)))*/
      ..body = Code('''
    return $nameClass(      
      ${attributes.map((field) => '${field.name}: ${field.name.toLowerCase()} ?? this.${field.name},').join('\n')}
    );
  '''));

    final toMapMethod = Method((b) => b
      ..name = 'toMap'
      ..annotations.add(refer('override'))
      ..returns = refer('Map<String, dynamic>')
      ..body = Block.of([
        Code('return <String, dynamic>{'),
        for (Field field in attributes) Code("'${field.name}': ${field.name},"),
        Code('};'),
      ]));

    final classBuilder = Class((b) => b
      ..name = nameClass
      ..extend = refer('Entity')
      ..fields.addAll(attributes)
      ..constructors.add(constructor)
      ..methods.addAll([copyWithMethod, toMapMethod]));

    // Criando a biblioteca com os imports e a classe
    final library = Library((b) => b
      ..directives.addAll(imports)
      ..body.add(classBuilder));

    // Gerando o código fonte da classe
    final emitter = DartEmitter();
    final source = library.accept(emitter).toString();

    // Formatando o código
    final formatter = DartFormatter();
    final formattedSource = formatter.format(source);
    //String output = _dartfmt.format('${formattedSource}');
    // Escrevendo o código em um arquivo
    // Obtendo o caminho para a pasta lib
//    final directory = await getApplicationDocumentsDirectory();
// Obtendo o caminho para a pasta lib do projeto Flutter
    final projectDirectory = Directory.current;
    String libPath = path.join(projectDirectory.path, 'lib');
    libPath = path.join(libPath, 'domain/models/models.dart');
    // Criando o arquivo dentro da pasta lib
    final File outputFile = File(libPath);
    if (outputFile.existsSync()) {
      outputFile.deleteSync();
    }

    outputFile.writeAsStringSync(formattedSource);

    return formattedSource;
  }

  @override
  void create(String tableName, void Function(Table table) callback) {
    // TODO: implement create
  }

  @override
  Future<dynamic> run() {
    // TODO: implement run
    throw UnimplementedError();
  }
  
  @override
  Future<String> toSql() {
    // TODO: implement toSql
    throw UnimplementedError();
  }
}
