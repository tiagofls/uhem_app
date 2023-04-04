import 'package:flutter/material.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/pages/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Alegreya'),
      home: const ConfirmAccessCode(),
    );
  }
}