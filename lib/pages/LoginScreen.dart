import 'package:flutter/material.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/routes/RouterConstants.dart';
import 'package:uhem_app/widgets/RoadCarImage.dart';

import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/UButton.dart';
import '../widgets/ULink.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController snsCtrl = TextEditingController();
  TextEditingController caCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(context) / 25,
            ),
            RoadCarImage(context),
            SizedBox(height: getHeight(context) / 7.5),
            AppTitle(context, 35, "UberHealth EasyMove"),
            const SizedBox(
              height: 40,
            ),
            InputText(context, 'Sns', 'Introduza o seu nº do SNS', snsCtrl),
            const SizedBox(
              height: 15,
            ),
            InputText(context, 'Código de Acesso',
                'Introduza o seu código de acesso', caCtrl),
            const SizedBox(
              height: 25,
            ),
            UButton(() async {
              setState(() {
                loading = true;
              });
              bool res = await Login(context, snsCtrl.text, caCtrl.text);
              setState(() {
                loading = false;
              });
              if (res) Navigator.pushNamed(context, HomeViewRoute);
            },
                "Entrar",
                Colors.white,
                const Color(0xFF156064),
                const StadiumBorder(),
                20,
                FontWeight.w700,
                4.0,
                const Color(0xFF00C49A)),
            SizedBox(
              height: getHeight(context) / 6,
            ),
            ULink(
                () {Navigator.pushNamed(context, AccessCodeViewRoute);}, "Como obtenho o meu código de acesso?", Colors.grey, 15)
          ],
        ));
  }
}
