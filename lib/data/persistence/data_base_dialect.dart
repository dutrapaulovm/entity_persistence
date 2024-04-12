///Represents a dialect of SQL implemented by a particular RDBMS
class Dialect {
  static const String arrayTypeName = "ARRAY";
  static const String bigintTypeName = "BIGINT";
  static const String binaryTypeName = "BINARY";
  static const String bitTypeName = "BIT";
  static const String blobTypeName = "BLOB";
  static const String booleanTypeName = "BOOLEAN";
  static const String charTypeName = "CHAR";
  static const String clobTypeName = "CLOB";
  static const String dateTypeName = "DATE";
  static const String decimalTypeName = "DECIMAL";
  static const String distinctTypeName = "DISTINCT";
  static const String doubleTypeName = "DOUBLE";
  static const String floatTypeName = "FLOAT";
  static const String integerTypeName = "INTEGER";
  static const String longVarbinaryTypeName = "LONGVARBINARY";
  static const String longVarcharTypeName = "LONGVARCHAR";
  static const String nullTypeName = "NULL";
  static const String numericTypeName = "NUMERIC";
  static const String otherTypeName = "OTHER";
  static const String realTypeName = "REAL";
  static const String refTypeName = "REF";
  static const String smallintTypeName = "SMALLINT";
  static const String structTypeName = "STRUCT";
  static const String timeTypeName = "TIME";
  static const String timestampTypeName = "TIMESTAMP";
  static const String timeWithZoneTypeName = "TIME WITH TIME ZONE";
  static const String timestampWithZoneTypeName = "TIMESTAMP WITH TIME ZONE";
  static const String tinyintTypeName = "TINYINT";
  static const String varbinaryTypeName = "VARBINARY";
  static const String varcharTypeName = "VARCHAR";
  static const String xmlTypeName = "XML";
  static const String xmlTypeEncoding = "UTF-8";

  static String get provider => "";
}

///A Dialect SQL for SQLite
class SQLiteDialect extends Dialect {
  static String get provider => "sqlite";
}

///A Dialect SQL for MySQL
class MySQLDialect extends Dialect {
  static String get provider => "mysql";
}
