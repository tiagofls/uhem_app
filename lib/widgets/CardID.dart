import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/functions/Patient.dart';
import 'package:uhem_app/models/Patient.dart';
import 'package:uhem_app/widgets/UText.dart';

  
  

Widget CardID(BuildContext context, Patient p) {


  return Container(
    height: getHeight(context)/8,
    width: getWidth(context)/1.3,
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF156064),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.person_alt, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.name, const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.heart_circle, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.sns, const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            ),
            const SizedBox(width: 15,),
            const Icon(CupertinoIcons.calendar, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.birthdate, const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            ),
          ],
        ),
      ],
    ),
  );
}



Widget CardIDCuidador(BuildContext context, Patient p, String username) {


  return Container(
    height: getHeight(context)/6.3,
    width: getWidth(context)/1.3,
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 22, 127, 175),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.person_alt, size: 30, color: Color.fromARGB(255, 22, 127, 175)),
            UText("Cuidador: ", Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(username, Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.person, size: 30, color: Color.fromARGB(255, 22, 127, 175)),
            UText("Cuidando: ", Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.name, Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.heart_circle, size: 30, color: Color.fromARGB(255, 22, 127, 175)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.sns, Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            ),
            const SizedBox(width: 15,),
            const Icon(CupertinoIcons.calendar, size: 30, color: Color.fromARGB(255, 22, 127, 175)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(p.birthdate, const Color.fromARGB(255, 22, 127, 175), FontWeight.w500, 20, TextAlign.start),
            ),
          ],
        ),
      ],
    ),
  );
}