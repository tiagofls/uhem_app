import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/pages/HistoryScreen.dart';
import 'package:uhem_app/pages/HomePageScreen.dart';
import 'package:uhem_app/pages/LoginScreen.dart';
import 'pages/UndefinedView.dart';
import 'routes/Router.dart' as router;
import 'routes/RouterConstants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  bool prefs = await getsnssSF();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final prefs;
  const MyApp({this.prefs, super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              )),
      initialRoute: prefs ? HomeViewRoute : LoginViewRoute,
      theme: ThemeData(
          fontFamily: 'Alegreya', primaryColor: const Color(0xFF00C49A)),
    );
  }
}
