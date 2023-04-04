import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/Constants.dart';
import 'UText.dart';

Widget TravelTile(BuildContext context){
  return Container(
    height: getHeight(context)/6.5,
    width: getWidth(context)/1.3,
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Column(
    children: [
      Row(
          children: [
            const Icon(CupertinoIcons.calendar, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("12/02/2009", Colors.grey, FontWeight.w500, 20, TextAlign.start),
            ),
            SizedBox(width: 10,),
            const Icon(CupertinoIcons.layers_alt_fill , size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("Cardiologia", Colors.grey, FontWeight.w500, 19, TextAlign.start),
            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.map_pin_ellipse, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("Hospital de Santo António", Colors.grey, FontWeight.w500, 20, TextAlign.start),
            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.home, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("08:45H", Colors.grey, FontWeight.w500, 20, TextAlign.start),
            ),
            SizedBox(width: 10,),
            const Icon(CupertinoIcons.paperplane_fill , size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText("10:20H", Colors.grey, FontWeight.w500, 19, TextAlign.start),
            )
          ],
        ),
    ],
  ));
}