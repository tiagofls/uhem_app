import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppTitle(BuildContext context, double size){
  return Stack(
  children: <Widget>[
    // Stroked text as border.
    Text(
      'UberHealth EasyMove',
      style: TextStyle(
        fontFamily: 'Alegreya',
        decoration: TextDecoration.none,
        fontSize: size,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color =  const Color.fromARGB(255, 0, 196, 154),
      ),
    ),
    // Solid text as fill.
    Text(
      'UberHealth EasyMove',
      style: TextStyle(
        fontFamily: 'Alegreya',
        decoration: TextDecoration.none,
        fontSize: size,
        color: const Color.fromARGB(255, 13, 6, 6),
      ),
    ),
  ],
);
}