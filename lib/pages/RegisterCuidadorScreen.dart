import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';
import 'package:uhem_app/widgets/UButton.dart';

import '../constants/Constants.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class RegisterCuidadorScreen extends StatefulWidget {
  const RegisterCuidadorScreen({super.key});

  @override
  State<RegisterCuidadorScreen> createState() => _RegisterCuidadorScreenState();
}

class _RegisterCuidadorScreenState extends State<RegisterCuidadorScreen> {
  TextEditingController snsCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
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
            SizedBox(height: getHeight(context) / 15),
            AppTitleCuidador(context, 45, "Registo"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(getWidth(context)/7, 0, getWidth(context)/7, 0),
              child: UText(
                  "Insira os seus dados para que possamos criar o seu registo de cuidador.",
                  Colors.black,
                  FontWeight.w400,
                  22, TextAlign.center),
            ),
            const SizedBox(
              height: 20,
            ),
             InputTextCuidador(context, 'Email', 'Introduza o seu email', snsCtrl),
          const SizedBox(height: 15,),
          //InputTextCuidador(context, 'Palavra-Passe', 'Introduza a sua palavra-passe', emailCtrl),
          //const SizedBox(height: 25,),
           UButton(() async {
              if(await TokenCuidador(snsCtrl.text)){
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('username', snsCtrl.text);
                Navigator.pushNamed(context, CuidadorPasswordRoute);
              }
              else {
                UAlertDialog(context, 'Erro', 'Não foi possível concluir o processo. Tente mais tarde.');
              }
            },
                "Confirmar",
                Colors.white,
                Color.fromARGB(255, 0, 18, 67),
                const StadiumBorder(),
                20,
                FontWeight.w700,
                4.0,
                const Color.fromARGB(255, 38, 186, 255)),
                SizedBox(height: getHeight(context)/20,),
          ULink((){Navigator.pushNamed(context, LoginViewRoute);}, "Já está registado? Entre aqui!", Colors.grey, 15)
          ],
        ));
  }
}