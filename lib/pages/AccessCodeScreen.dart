import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uhem_app/widgets/ULink.dart';
import 'package:uhem_app/widgets/UText.dart';

import '../constants/Constants.dart';
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
                  "Insera os seus dados para que possamos gerar um novo código de acesso.",
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
            UButton((){}, "Continuar", Colors.white, const Color(0xFF156064), const StadiumBorder(), 
          20, FontWeight.w700, 4.0, const Color(0xFF00C49A)),
          SizedBox(height: getHeight(context)/9,),
          ULink((){}, "Já tenho um código de acesso", Colors.grey, 15)
          ],
        ));
  }
}
