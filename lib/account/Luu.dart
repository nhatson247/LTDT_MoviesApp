import 'package:flutter/cupertino.dart';
import 'taikhoan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  TaiKhoan? _loggedInStudent;

  TaiKhoan? get loggedInStudent => _loggedInStudent;

  void setLoggedInStudent(TaiKhoan student) {
    _loggedInStudent = student;
    notifyListeners();
  }

  void logout() async {
    _loggedInStudent = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('hoten');
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

