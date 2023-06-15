import 'package:flutter/material.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/pages/RegisterCuidadorScreen.dart';
import 'package:uhem_app/routes/RouterConstants.dart';
import 'package:uhem_app/widgets/RoadCarImage.dart';

import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/UButton.dart';
import '../widgets/ULink.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreenCuidador extends StatefulWidget {
  const LoginScreenCuidador({super.key});

  @override
  State<LoginScreenCuidador> createState() => _LoginScreenCuidadorState();
}

class _LoginScreenCuidadorState extends State<LoginScreenCuidador> {
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
            SizedBox(height: getHeight(context) / 10),
            AppTitleCuidador(context, 35, "MedTransport EasyMove"),
            const SizedBox(
              height: 40,
            ),
            InputTextCuidador(context, 'Email', 'Introduza o seu email', snsCtrl),
            const SizedBox(
              height: 15,
            ),
            InputTextCuidador(context, 'Palavra-Passe',
                'Introduza a sua palavra-passe', caCtrl),
            const SizedBox(
              height: 25,
            ),
            UButton(() async {
              setState(() {
                loading = true;
              });
              bool res = await LoginCuidador(context, snsCtrl.text, caCtrl.text);
              setState(() {
                loading = false;
              });
              if (res) Navigator.pushNamed(context, CuidadorHomeRoute);
            },
                "Entrar",
                Colors.white,
                Color.fromARGB(255, 0, 18, 67),
                const StadiumBorder(),
                20,
                FontWeight.w700,
                4.0,
                const Color.fromARGB(255, 38, 186, 255)),
                SizedBox(height: getHeight(context)/20,),
                UButton((){
                  Navigator.pushNamed(context, LoginViewRoute);
                }, 'MedTrasnport Paciente', Colors.white,
                Color.fromARGB(255, 41, 114, 87),
                const StadiumBorder(),
                15,
                FontWeight.w700,
                4.0,
                const Color(0xFF00C49A)),
            SizedBox(
              height: getHeight(context) / 20,
            ),
            ULink(
                () {Navigator.pushNamed(context, RegisterCuidadorRoute);}, "Ainda não está registado? Registe-se aqui", Colors.grey, 15)
          ],
        ));
  }
}
