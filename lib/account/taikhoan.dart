import 'dart:convert';
import 'package:crypto/crypto.dart';

class TaiKhoan {
  String masv;
  String hoten;
  String matkhau;
  String email;

  TaiKhoan({
    required this.masv,
    required this.hoten,
    required this.matkhau,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'masv': masv,
      'hoten': hoten,
      'matkhau': matkhau,
      'email': email,
    };
  }

  factory TaiKhoan.fromMap(Map<String, dynamic> map) {
    return TaiKhoan(
      masv: map['masv'],
      hoten: map['hoten'],
      matkhau: map['matkhau'],
      email: map['email'],
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void changePassword(String newPassword) {
    matkhau = generateMd5(newPassword);
  }
}
