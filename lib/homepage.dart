import 'package:flutter/material.dart';
import 'package:testing/screens/account/account_screen.dart';
import 'package:testing/screens/Movies/home_screen.dart';
import 'package:testing/screens/search/search.dart';
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
    SearchMovies(),
    UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: _navigateBottomNavBar,
        backgroundColor: kColorDF,
        unselectedItemColor: Colors.grey[300],
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Account"),
        ],
      )
    );
  }
}