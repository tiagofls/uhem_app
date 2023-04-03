import 'package:flutter/material.dart';

Widget ULink(Function() func, String texto, Color clr, double size){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextButton(onPressed: func,
      child: Text(texto ,style: TextStyle(decoration: TextDecoration.underline,
      color: clr, fontSize: size, fontFamily: 'Alegreya'))),
    ],
  );
}