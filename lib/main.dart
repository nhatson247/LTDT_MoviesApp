import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:testing/screens/Movies/home_screen.dart';

import 'Luu.dart';
import 'account/login.dart';


void main() {
  databaseFactory = databaseFactoryFfiWeb;
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movie",
      home: authProvider.loggedInStudent != null ? HomeScreen() : Login(),
    );
  }
}

