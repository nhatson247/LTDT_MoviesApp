import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testing/account/sql_helper.dart';
import 'package:testing/account/taikhoan.dart';
import 'package:crypto/crypto.dart';
import 'package:testing/screens/Movies/home_screen.dart';
import 'dart:convert';
import 'Luu.dart';
import '../homepage.dart';
import '../utils/colors.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController _matkhaucuController = TextEditingController();
  final TextEditingController _matkhaumoiController = TextEditingController();
  final TextEditingController _nhaplaimatkhaumoiController = TextEditingController();
  TaiKhoan? _loggedInStudent;

  @override
  void initState() {
    super.initState();
    _loggedInStudent = Provider.of<AuthProvider>(context, listen: false).loggedInStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildTitle("Đổi mật khẩu"),
                  const SizedBox(height: 20),
                  buildTextField(_matkhaucuController, "Mật khẩu cũ", Colors.white, Icons.password, isPassword: true),
                  buildTextField(_matkhaumoiController, "Mật khẩu mới ", Colors.white, Icons.password, isPassword: true),
                  buildTextField(_nhaplaimatkhaumoiController, "Nhập lại mật khẩu mới ", Colors.white, Icons.password, isPassword: true),
                  const SizedBox(height: 15),
                  buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText, Color backgroundColor, IconData iconData, {bool isPassword = false}) {
    return Container(
      width: 327,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: backgroundColor,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            fillColor: Colors.black,
            prefixIcon: Icon(
              iconData,
              color: Colors.black,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return InkWell(
      onTap: () {
        _changePassword(context);
        HomeScreen();
      },
      child: Container(
        width: 327,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'Đổi mật khẩu',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void _changePassword(BuildContext context) async {
    try {
      String matkhaucu = generateMd5(_matkhaucuController.text.trim());
      String matkhaumoi = _matkhaumoiController.text.trim();
      String nhaplaimatkhaumoi = _nhaplaimatkhaumoiController.text.trim();

      if (_loggedInStudent == null) {
        throw ('Không có tài khoản đăng nhập.');
      }

      if (matkhaucu.isEmpty || matkhaumoi.isEmpty || nhaplaimatkhaumoi.isEmpty) {
        throw ('Vui lòng điền đầy đủ thông tin.');
      }

      if (_loggedInStudent!.matkhau != matkhaucu) {
        throw ('Mật khẩu cũ không đúng');
      }

      if (matkhaucu == generateMd5(matkhaumoi)) {
        throw ('Mật khẩu mới không được giống mật khẩu cũ.');
      }

      if (matkhaumoi != nhaplaimatkhaumoi) {
        throw ('Mật khẩu mới không khớp.');
      }

      _loggedInStudent!.changePassword(matkhaumoi);

      final SQLHelper dbHelper = SQLHelper();
      await dbHelper.initDB();
      await dbHelper.updatePassword(_loggedInStudent!.masv, _loggedInStudent!.matkhau);

      Provider.of<AuthProvider>(context, listen: false).updateLoggedInStudent(_loggedInStudent!);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green[300],
          title: const Text(
            'Đổi mật khẩu thành công',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHomePage(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('lỗi: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    Provider.of<AuthProvider>(context, listen: false).refreshHomePage();
  }


}
