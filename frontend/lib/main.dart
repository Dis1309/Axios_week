import 'package:flutter/material.dart';
import 'package:frontend/pages/homePage.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context)=>IntroductionApp(),
        '/login':(context) => Login(),
        '/register':(context)=>Register()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
