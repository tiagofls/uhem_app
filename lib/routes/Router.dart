
import 'package:flutter/material.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/pages/CuidadorDetailTravel.dart';
import 'package:uhem_app/pages/CuidadorPasswordScreen.dart';
import 'package:uhem_app/pages/HistoryCuidadorScreen.dart';
import 'package:uhem_app/pages/HistoryScreen.dart';
import 'package:uhem_app/pages/HomePageScreen.dart';
import 'package:uhem_app/pages/LoginScreen.dart';
import 'package:uhem_app/pages/LoginScreenCuidador.dart';
import 'package:uhem_app/pages/RegisterCuidadorScreen.dart';
import 'package:uhem_app/pages/TravelDetailPage.dart';
import 'package:uhem_app/routes/RouterConstants.dart';

import '../pages/CuidadorHomeScreen.dart';
import '../pages/RegistarSnsScreen.dart';
import '../pages/UndefinedView.dart';

Route<String> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => const HomePageScreen());
    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case AccessCodeViewRoute:
      return MaterialPageRoute(builder: (context) => const AccessCodeScreen());
    case ConfirmAccessCodeViewRoute:
      return MaterialPageRoute(builder: (context) => const ConfirmAccessCode());
    case HistoryScreenRoute:
      return MaterialPageRoute(builder: (context) => const HistoryScreen());
    case DetailViewRoute:
      return MaterialPageRoute(
          builder: (context) => const TravelDetailPage());
    case LoginCuidadorRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreenCuidador());
    case RegisterCuidadorRoute:
      return MaterialPageRoute(builder: (context) => const RegisterCuidadorScreen());
    case CuidadorPasswordRoute:
      return MaterialPageRoute(builder: (context) => const CuidadorPasswordScreen());
    case CuidadorHomeRoute:
      return MaterialPageRoute(builder: (context) => const CuidadorHomeScreen());
    case RegistarSnsRoute:
      return MaterialPageRoute(builder: (context) => const RegistarSnsScreen());
    case HistoryCuidadorScreenRoute:
      return MaterialPageRoute(builder: (context) => const HistoryCuidadorScreen());
    case CuidadorDetailViewRoute:
      return MaterialPageRoute(builder: (context) => const CuidadorDetailTravel());
    default:
      return MaterialPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name,
          key: null,
        ),
      );
  }
}

 /**
  * SharedPreferences prefs = await SharedPreferences.getInstance();
  String? sns = prefs.getString('sns');
  */
