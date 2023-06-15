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

class CuidadorPasswordScreen extends StatefulWidget {
  const CuidadorPasswordScreen({super.key});

  @override
  State<CuidadorPasswordScreen> createState() => _CuidadorPasswordScreenState();
}

class _CuidadorPasswordScreenState extends State<CuidadorPasswordScreen> {
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
              padding: EdgeInsets.fromLTRB(
                  getWidth(context) / 7, 0, getWidth(context) / 7, 0),
              child: UText(
                  "Após inserir o token de verificação, poderá inserir a nova palavra-passe.",
                  Colors.black,
                  FontWeight.w400,
                  22,
                  TextAlign.center),
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextCuidador(
                context, 'Token', 'Introduza o token de acesso', snsCtrl),
            const SizedBox(
              height: 15,
            ),
            InputTextCuidador(context, 'Palavra-Passe', 'Introduza a sua palavra-passe', emailCtrl),
            const SizedBox(height: 25,),
            UButton(() async {
              var prefs = await SharedPreferences.getInstance();
              String u = prefs.getString('username') ?? ''; 
              if (await CuidadorVerifyToken(u, snsCtrl.text, emailCtrl.text)) {
                Navigator.pushNamed(context, RegistarSnsRoute);
              } else {
                UAlertDialog(context, 'Erro',
                    'Não foi possível verificar o email que forneceu!');
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
            SizedBox(
              height: getHeight(context) / 20,
            ),
            ULink(() {
              Navigator.pushNamed(context, LoginViewRoute);
            }, "Já está registado? Entre aqui!", Colors.grey, 15)
          ],
        ));
  }
}
