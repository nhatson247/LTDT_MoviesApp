import 'package:testing/account/taikhoan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  final databaseName = "taikhoan.db";

  String taiKhoanTable =
      "create table tai_khoan (masv TEXT PRIMARY KEY, hoten TEXT, matkhau TEXT, email TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    bool databaseExists = await databaseFactory.databaseExists(path);
    if (!databaseExists) {
      return openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute(taiKhoanTable);
      });
    } else {
      return openDatabase(path, version: 1);
    }
  }

  Future<int> signup(TaiKhoan taiKhoan) async {
    final Database db = await initDB();
    return db.insert('tai_khoan', taiKhoan.toMap());
  }

  Future<int> createAccount(TaiKhoan taiKhoan) async {
    final Database db = await initDB();
    return db.insert('tai_khoan', taiKhoan.toMap());
  }

  Future<List<TaiKhoan>> getAccount() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('tai_khoan');
    return result.map((e) => TaiKhoan.fromMap(e)).toList();
  }

  Future<bool> FindSV(String masv) async {
    final Database db = await initDB();
    var result = await db.query(
      'tai_khoan',
      where: 'masv = ?',
      whereArgs: [masv],
    );
    return result.isNotEmpty;
  }
}
