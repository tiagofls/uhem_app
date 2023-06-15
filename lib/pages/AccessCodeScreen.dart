import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/pages/ConfAccessCode.dart';
import 'package:uhem_app/routes/RouterConstants.dart';
import 'package:uhem_app/widgets/ULink.dart';
import 'package:uhem_app/widgets/UText.dart';

import '../constants/Constants.dart';
import '../functions/UAlertDialog.dart';
import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/UButton.dart';

class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen({super.key});

  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}

class _AccessCodeScreenState extends State<AccessCodeScreen> {
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
            AppTitle(context, 45, "Código de Acesso"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(getWidth(context)/7, 0, getWidth(context)/7, 0),
              child: UText(
                  "Insira os seus dados para que possamos gerar um novo código de acesso.",
                  Colors.black,
                  FontWeight.w400,
                  22, TextAlign.center),
            ),
            const SizedBox(
              height: 20,
            ),
             InputText(context, 'Sns', 'Introduza o seu nº do SNS', snsCtrl),
          const SizedBox(height: 15,),
          InputText(context, 'E-mail', 'Introduza o seu e-mail', emailCtrl),
          const SizedBox(height: 25,),
            UButton(() async {
              print("Continuar no codigo de acesso");
              if( await GenerateToken(snsCtrl.text, emailCtrl.text)){
                Navigator.pushNamed(context, ConfirmAccessCodeViewRoute);
              }
              else{
                UAlertDialog(context, 'Credenciais Inválidas', "O par SNS/EMAIL que introduziu não é válido!");
              }
            }, "Continuar", Colors.white, const Color(0xFF156064), const StadiumBorder(), 
          20, FontWeight.w700, 4.0, const Color(0xFF00C49A)),
          SizedBox(height: getHeight(context)/9,),
          ULink((){Navigator.pushNamed(context, LoginViewRoute);}, "Já tenho um código de acesso", Colors.grey, 15)
          ],
        ));
  }
}
