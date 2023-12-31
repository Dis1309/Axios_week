import 'package:flutter/material.dart';
import 'package:frontend/pages/fingerprint.dart';
import 'package:frontend/pages/homePage.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/signup.dart';
import './pages/mainPage/mainPage.dart';

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
        '/register':(context)=>Register(),
        '/mainpage':(context) => MainPage(),
        '/fingerprint':(context) => FingerPrint()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
