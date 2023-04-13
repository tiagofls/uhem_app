// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:uhem_app/constants/Constants.dart';

Widget UButton(
    Function() func,
    String texto,
    Color fgColor,
    Color bgColor,
    OutlinedBorder outBorder,
    double size,
    FontWeight wei,
    double bWidth,
    Color bColor,
    [LoadingIndicator? indicator]) {
  return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        foregroundColor: fgColor,
        backgroundColor: bgColor,
        shape: outBorder,
        side: BorderSide(
          width: bWidth,
          color: bColor,
        ),
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        textStyle:
            TextStyle(fontFamily: 'Alegreya', fontSize: size, fontWeight: wei),
      ),
      child: loading
          ? const SizedBox(
              width: 30,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Colors.white],
              ),
            )
          : Text(texto));
}
