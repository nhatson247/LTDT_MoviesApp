import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/account/signup.dart';
import 'package:testing/account/sql_helper.dart';
import 'package:testing/account/taikhoan.dart';
import 'package:testing/homepage.dart';
import '../Luu.dart';
import '../utils/colors.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyLoginState();
}

class _MyLoginState extends State<Login> {
  final TextEditingController _masvController = TextEditingController();
  final TextEditingController _matkhauController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkSavedLogin();
  }

  void _checkSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hoten = prefs.getString('hoten');

    if (hoten != null) {
      TaiKhoan loggedInStudent =
          TaiKhoan(hoten: hoten, masv: "", matkhau: "", email: "");
      Provider.of<AuthProvider>(context, listen: false)
          .setLoggedInStudent(loggedInStudent);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildTitle("Đăng Nhập Hệ Thống"),
                  const SizedBox(height: 20),
                  buildTextField(_masvController, "Mã Sinh Viên", Colors.white,
                      Icons.person),
                  buildTextField(_matkhauController, "Mật khẩu", Colors.white,
                      Icons.password,
                      isPassword: true),
                  const SizedBox(height: 15),
                  buildLoginButton(),
                  buildText("Bạn chưa có tài khoản? Đăng ký Tại đây")
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
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
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
        _login();
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
            'Đăng Nhập',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final List<TaiKhoan> students = await SQLHelper().getAccount();
    TaiKhoan? loggedInStudent;

    for (TaiKhoan student in students) {
      if (student.masv == _masvController.text &&
          student.matkhau == _matkhauController.text) {
        loggedInStudent = student;
        break;
      }
    }

    if (loggedInStudent != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('hoten', loggedInStudent.hoten);

      Provider.of<AuthProvider>(context, listen: false)
          .setLoggedInStudent(loggedInStudent);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Mã sinh viên hoặc mật khẩu không đúng.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
