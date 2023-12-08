import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'account/Luu.dart';
import 'account/login.dart';
import 'homepage.dart';

void main() {
  databaseFactory = databaseFactoryFfiWeb;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Movie",
          home: authProvider.loggedInStudent != null ? HomePage() : Login(),
        );
      },
    );
  }
}

