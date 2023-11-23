import 'package:testing/account/taikhoan.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(""" CREATE TABLE tai_khoan
    (masv TEXT PRIMARY KEY,
     hoten TEXT,
     matkhau TEXT,  
     email TEXT 
     )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("taikhoan.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createStudent(TaiKhoan taiKhoan) async {
    final db = await SQLHelper.db();
    return db.insert('tai_khoan', taiKhoan.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<TaiKhoan>> getStudents() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('tai_khoan');
    return List.generate(
      maps.length,
      (i) {
        return TaiKhoan.fromMap(maps[i]);
      },
    );
  }
}
