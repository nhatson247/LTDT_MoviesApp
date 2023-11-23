import 'package:flutter/material.dart';
import 'package:testing/account/signup.dart';
import 'package:testing/account/sql_helper.dart';
import 'package:testing/account/taikhoan.dart';

import 'login.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _navigateToLogin() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sinh viên'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              _navigateToLogin();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<TaiKhoan>>(
        future: SQLHelper.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Không có sinh viên nào.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TaiKhoan student = snapshot.data![index];
                return ListTile(
                  title: Text('${student.masv}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Họ và tên: ${student.hoten}'),
                      Text('Email: ${student.email}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignUp(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
