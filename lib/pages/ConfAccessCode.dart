import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                  "Enviamos um código de confirmação para o seu e-mail",
                  Colors.black,
                  FontWeight.w400,
                  22, TextAlign.center),
            ),
            const SizedBox(
              height: 40,
            ),
          InputText(context, 'Código de Confirmação', 'Introduza o código de confirmação', emailCtrl),
          const SizedBox(height: 25,),
            UButton((){}, "Continuar", Colors.white, const Color(0xFF156064), const StadiumBorder(), 
          20, FontWeight.w700, 4.0, const Color(0xFF00C49A)),
          SizedBox(height: getHeight(context)/9,),
          ULink((){}, "Não recebi nenhum código no meu e-mail", Colors.grey, 15)
          ],
        ));
  }
}