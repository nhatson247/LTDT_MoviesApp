

import 'package:flutter/cupertino.dart';

import 'account/taikhoan.dart';

class AuthProvider extends ChangeNotifier {
  TaiKhoan? _loggedInStudent;

  TaiKhoan? get loggedInStudent => _loggedInStudent;

  void setLoggedInStudent(TaiKhoan student) {
    _loggedInStudent = student;
    notifyListeners();
  }

  void logout() {
    _loggedInStudent = null;
    notifyListeners();
  }
}
