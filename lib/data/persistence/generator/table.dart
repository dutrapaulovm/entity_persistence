import 'package:entity_persistence/entity_persistence.dart';

/// Classe que representa uma tabela de banco de dados.
class Table {
  final Map<String, ColumnMember> _columns = {};

  late String name;

  /// Método para adicionar uma coluna do tipo VARCHAR à tabela.
  ///
  /// Recebe o [name] da coluna como parâmetro e retorna uma instância
  /// de [ColumnMember].
  ColumnMember varchar(String name) {
    var col = ColumnMember(name: name);
    addColumn(name, col);
    return col;
  }

  /// Método para adicionar uma coluna do tipo VARCHAR à tabela.
  ///
  /// Recebe o [name] da coluna como parâmetro e retorna uma instância
  /// de [ColumnMember].
  ColumnMember doublePrecision(String name) {
    var col = ColumnMember(name: name, type: ColumnType.doublePrecision);
    addColumn(name, col);
    return col;
  }

  /// Método para adicionar uma coluna à tabela.
  ///
  /// Recebe o [name] da coluna e um [columnMember] como parâmetros.
  /// Se uma coluna com o mesmo nome já foi adicionada à tabela, lança
  /// uma exceção [ColumnDuplicateError].
  void addColumn(String name, ColumnMember columnMember) {
    if (!_columns.containsKey(name)) {
      _columns[name] = columnMember;
    } else {
      throw ColumnDuplicateError("Coluna $name já foi declarada");
    }
  }

  String toSql() {
    int index = 0;
    StringBuffer buffer = StringBuffer();
    _columns.forEach((key, value) {
      if (index > 0) {
        buffer.write(',');
      }
      buffer.write(value.name);
      buffer.write(' ');
      buffer.write(value.type);
      if (value.isNullable) {
        buffer.write(" NOT NULL");
      }
      if (value.isPrimaryKey) {
        buffer.write(" PRIMARY KEY");
      }
      index++;
    });

    return buffer.toString();
  }
}
