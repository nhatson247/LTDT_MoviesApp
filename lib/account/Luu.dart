import 'package:flutter/cupertino.dart';
import 'taikhoan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  TaiKhoan? _loggedInStudent;
  String? _loggedInMasv;

  TaiKhoan? get loggedInStudent => _loggedInStudent;

  String? get loggedInMasv => _loggedInMasv;

  void setLoggedInStudent(TaiKhoan student) {
    _loggedInStudent = student;
    _loggedInMasv = student.masv;
    notifyListeners();
  }

  void logout() async {
    _loggedInStudent = null;
    _loggedInMasv = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('hoten');
    if (_loggedInMasv != null) {
      prefs.remove(_loggedInMasv!);
    }
    notifyListeners();
  }

  void refreshHomePage() {
    notifyListeners();
  }

  void updateLoggedInStudent(TaiKhoan student) {
    if (_loggedInStudent != null) {
      _loggedInStudent!.hoten = student.hoten;
      _loggedInStudent!.matkhau = student.matkhau;
      _loggedInStudent!.email = student.email;
      notifyListeners();
    }
  }
}