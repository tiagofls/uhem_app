import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/pages/CuidadorHomeScreen.dart';
import 'package:uhem_app/routes/RouterConstants.dart';
import 'package:uhem_app/widgets/RoadCarImage.dart';

import '../functions/Login.dart';
import '../functions/UAlertDialog.dart';
import '../widgets/AppTitle.dart';
import '../widgets/InputText.dart';
import '../widgets/UButton.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class RegistarSnsScreen extends StatefulWidget {
  const RegistarSnsScreen({super.key});

  @override
  State<RegistarSnsScreen> createState() => _RegistarSnsScreenState();
}

class _RegistarSnsScreenState extends State<RegistarSnsScreen> {
  TextEditingController snsCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  bool enabled = false;
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
            AppTitleCuidador(context, 45, "Associar SNS"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(getWidth(context)/7, 0, getWidth(context)/7, 0),
              child: UText(
                  "Insira o SNS a associar. Irá receber um token de segurança num dos contacto do utente. Após essa validação, o registo estará concluído.",
                  Colors.black,
                  FontWeight.w400,
                  22, TextAlign.center),
            ),
            const SizedBox(
              height: 20,
            ),
             InputTextCuidador(context, 'SNS', 'Introduza o nº do SNS', snsCtrl),
          const SizedBox(height: 15,),
          if(enabled) ...{
          InputTextCuidador(context, 'Token', 'Introduza o token de segurança', emailCtrl),
          const SizedBox(height: 25,),
          },
           UButton(() async {
              if(enabled){
                Navigator.pushNamed(context, CuidadorHomeRoute);
              }
              else{
                var prefs = await SharedPreferences.getInstance();
                String u = prefs.getString('username') ?? ''; 
                prefs.setString('sns', snsCtrl.text);
                await AssocSns(u, snsCtrl.text);
                setState(() {
                  enabled = true;
                });
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