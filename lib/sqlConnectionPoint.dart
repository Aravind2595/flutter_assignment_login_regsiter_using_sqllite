import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQL_Operations {
  static Future<sql.Database> openDb() async {
    return sql.openDatabase('administartion', version: 1,
        onCreate: (sql.Database db, int version) async {
          createTable(db);
        });
  }

  static Future<void> createTable(sql.Database db) async {
    await db.execute('CREATE TABLE client ('
        'id INTEGER PRIMARY KEY autoincrement not null,'
        'userName TEXT, '
        'email TEXT, '
        'password TEXT)');
  }

  static Future<int> createAccountSQL(String? uNameSQL, String? emailIdSQL,
      String? passwordSQL) async {
    final db = await SQL_Operations.openDb();
    final data = {
      'userName': uNameSQL,
      'email': emailIdSQL,
      'password': passwordSQL
    };
    final id = await db.insert(
        'client', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> signInAccountSQL(String? emailIdSQL,
      String? passwordSQL) async {
    final db = await SQL_Operations.openDb();
    final List<Map<String, dynamic>> account = await db.query(
        'client', columns: ['userName'],
        where: "email=? AND password=?",
        whereArgs: [emailIdSQL,passwordSQL]);
    return account;
  }
}
