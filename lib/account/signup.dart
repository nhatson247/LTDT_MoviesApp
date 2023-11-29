import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/account/login.dart';
import 'package:testing/account/sql_helper.dart';
import 'package:testing/account/taikhoan.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<SignUp> {
  final TextEditingController _masvController = TextEditingController();
  final TextEditingController _hotenController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matkhauController = TextEditingController();
  final TextEditingController _confirmMatkhauController =
      TextEditingController();
  bool _isValidEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildTitle("Đăng ký tài khoản"),
                  const SizedBox(height: 20),
                  buildSubtitle(
                      "Vui lòng điền thông tin của bạn vào form dưới đây."),
                  const SizedBox(height: 20),
                  buildTextField(_masvController, "Mã Sinh Viên", Colors.white,
                      Icons.person),
                  buildTextNameField(
                      _hotenController, "Họ Tên", Colors.white, Icons.abc),
                  myEditEmail(
                      _emailController, "Email", Colors.white, Icons.email),
                  buildTextField(_matkhauController, "Mật khẩu", Colors.white,
                      Icons.password,
                      isPassword: true),
                  buildTextField(_confirmMatkhauController, "Nhập lại mật khẩu",
                      Colors.white, Icons.password,
                      isPassword: true),
                  const SizedBox(height: 15),
                  buildSignUpButton(),
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
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildSubtitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.black),
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

  Widget buildTextNameField(TextEditingController controller, String hintText, Color backgroundColor, IconData iconData) {
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
            FilteringTextInputFormatter.deny(RegExp(r'\d')),
          ],
        ),
      ),
    );
  }

  Widget myEditEmail(TextEditingController controller, String content, Color backgroundcolor, IconData iconData) {
    return Container(
      width: 327,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: backgroundcolor,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextField(
          controller: controller,
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
            hintText: content,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            suffixIcon: _isValidEmail
                ? null
                : Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (text) {
            setState(() {
              _isValidEmail = EmailValidator.validate(text);
            });
          },
        ),
      ),
    );
  }

  Widget buildSignUpButton() {
    return InkWell(
      onTap: () {
        _registerStudent();
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
            'Đăng Ký',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerStudent() async {
    try {
      if (_isSignUpValid()) {
        TaiKhoan newStudent = TaiKhoan(
          masv: _masvController.text,
          hoten: _hotenController.text,
          email: _emailController.text,
          matkhau: _matkhauController.text,
        );

        SQLHelper sqlHelper = SQLHelper();
        await sqlHelper.signup(newStudent);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Đăng ký thành công'),
            content: const Text('Tài khoản đã được đăng ký thành công.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thông báo'),
            content: const Text(
                'Vui lòng điền đầy đủ thông tin và đảm bảo mật khẩu trùng khớp.'),
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
    } catch (e) {
      print('Lỗi khi đăng ký: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi'),
          content:
              const Text('Có lỗi xảy ra khi đăng ký. Vui lòng thử lại sau.'),
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

  bool _isSignUpValid() {
    bool isPasswordMatch =
        _matkhauController.text == _confirmMatkhauController.text;

    return _masvController.text.isNotEmpty &&
        _hotenController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        EmailValidator.validate(_emailController.text) &&
        _matkhauController.text.isNotEmpty &&
        isPasswordMatch;
  }
}