import 'package:flutter/material.dart';
import 'package:testing/account/login.dart';
import 'package:testing/account/sql_helper.dart';
import 'package:testing/account/taikhoan.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
        future: SQLHelper().getAccount(),
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
                    children: [
                      Text('${student.hoten} '),
                      Text('${student.matkhau} '),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
