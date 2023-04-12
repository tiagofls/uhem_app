import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/pages/HistoryScreen.dart';
import 'package:uhem_app/pages/HomePageScreen.dart';
import 'package:uhem_app/pages/LoginScreen.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Alegreya', primaryColor: const Color(0xFF00C49A)),
      home: const LoginScreen(),
    );
  }
}