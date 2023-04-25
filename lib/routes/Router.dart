import 'package:flutter/material.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/pages/HomePageScreen.dart';
import 'package:uhem_app/pages/LoginScreen.dart';
import 'package:uhem_app/routes/RouterConstants.dart';

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
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
                key: null,
              ));
  }
}
