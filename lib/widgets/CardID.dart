import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/widgets/UText.dart';

Widget CardID(BuildContext context){
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
          children: [
            const Icon(CupertinoIcons.person_alt, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("Nome Apelido", const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.heart_circle, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("123 456 789", const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            ),
            const SizedBox(width: 15,),
            const Icon(CupertinoIcons.calendar, size: 30, color: Color(0xFF156064)),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("12/05/1998", const Color(0xFF156064), FontWeight.w500, 20, TextAlign.start),
            ),
          ],
        ),
      ],
    ),
  );
}