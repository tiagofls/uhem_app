// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

Widget UText(String text, Color color, FontWeight wei, double size){
  return Text(
    text,
    style: TextStyle(
      decoration: TextDecoration.none,
      color: color,
      fontFamily: 'Alegreya',
      fontWeight: wei,
      fontSize: size
    ),
  );
}