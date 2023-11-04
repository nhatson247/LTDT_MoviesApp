import 'package:flutter/material.dart';
import 'package:testing/screens/account_screen.dart';
import 'package:testing/screens/home_screen.dart';
import 'package:testing/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  void _navigateBottomNavBar(int index){
    setState(() {
      _selectIndex = index;
    });
  }
// chuyen huong active
  final List<Widget> _children = [
    HomeScreen(),
    UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: _navigateBottomNavBar,
        backgroundColor: kSearchbarColor.withOpacity(0.9),
        unselectedItemColor: Colors.grey[300],
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Account"),
        ],
      )
    );
  }
}