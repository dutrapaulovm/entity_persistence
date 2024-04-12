import 'package:entity_persistence/data/persistence/entity.dart';

class SQLUtils {
  static String builderColumnsSelectFromMap(
      Entity entity, Map<String, dynamic> columns) {
    StringBuffer buffer = StringBuffer();
    List<String> cols = columns.keys.toList();

    buffer.write("${entity.entityName}.${cols[0]}");

    for (int i = 1; i < cols.length; i++) {
      buffer.write(" , ");
      buffer.write("${entity.entityName}.${cols[i]}");
    }

    return buffer.toString();
  }

  static String builderColumnsSelect(List<String> columns) {
    StringBuffer buffer = StringBuffer();

    buffer.write(columns[0]);

    for (var col in columns) {
      buffer.write(" , ");
      buffer.write(col);
    }

    return buffer.toString();
  }
}
