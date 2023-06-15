import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';

import '../constants/Constants.dart';
import '../functions/Travel.dart';
import 'UText.dart';


Widget TravelTile(
  BuildContext context,
  String eventDate,
  String eventType,
  String eventClinic,
  String eventTime
) {
  return Container(
    height: getHeight(context) / 6.5,
    width: getWidth(context) / 1.3,
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
              child: UText(eventDate, Colors.grey, FontWeight.w500, 20, TextAlign.start),
            ),
            const SizedBox(width: 10,),
            const Icon(CupertinoIcons.clock, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(eventTime, Colors.grey, FontWeight.w500, 20, TextAlign.start),
            ),
            
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.ant, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(eventType, Colors.grey, FontWeight.w500, 20, TextAlign.start)
        ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Icon(CupertinoIcons.map_pin_ellipse, size: 20, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 5, 0),
              child: UText(eventClinic, Colors.grey, FontWeight.w500, 20, TextAlign.start)
        ),
          ],
        ),
      ],
    ),
  );
}