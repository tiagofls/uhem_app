import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';
import 'package:uhem_app/pages/AccessCodeScreen.dart';
import 'package:uhem_app/routes/RouterConstants.dart';

import '../constants/Constants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/UButton.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class ConfirmAccessCode extends StatefulWidget {
  const ConfirmAccessCode({super.key});

  @override
  State<ConfirmAccessCode> createState() => _ConfirmAccessCodeState();
}

class _ConfirmAccessCodeState extends State<ConfirmAccessCode> {
    TextEditingController codeCtrl = TextEditingController();
    TextEditingController snsCtrl = TextEditingController();
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
                  "Enviamos um código de confirmação para o seu e-mail",
                  Colors.black,
                  FontWeight.w400,
                  22, TextAlign.center),
            ),
            const SizedBox(
              height: 40,
            ),
          InputText(context, 'Código de Confirmação', 'Introduza o código de confirmação', codeCtrl),
                    const SizedBox(height: 10,),

          InputText(context, 'SNS', 'Introduza novamente o seu nº SNS', snsCtrl),
          const SizedBox(height: 25,),
            UButton(() async{
              if(await verifyGenerateAccessCode(codeCtrl.text, snsCtrl.text)){
                addStringToSF(snsCtrl.text);
                Navigator.pushNamed(context, HomeViewRoute);
              }
              else{
                UAlertDialog(context, 'Erro', 'Código de Acesso inválido!');
              }
            }, "Continuar", Colors.white, const Color(0xFF156064), const StadiumBorder(), 
          20, FontWeight.w700, 4.0, const Color(0xFF00C49A)),
          SizedBox(height: getHeight(context)/9,),
          ULink((){Navigator.pushNamed(context, AccessCodeViewRoute);}, "Não recebi nenhum código no meu e-mail", Colors.grey, 15)
          ],
        ));
  }
}