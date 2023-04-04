import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/widgets/UText.dart';

Widget InputText(BuildContext context, String label, String hintText, TextEditingController txtCtrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: UText(label, Colors.black, FontWeight.w800, 18, TextAlign.start),
      ),
      Card(
        shadowColor: Colors.transparent,
        borderOnForeground: false,
        child: SizedBox(
          width: getWidth(context)/1.3,
          child: TextField(
            controller: txtCtrl,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 15),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 5, color: Color.fromARGB(255, 0, 196, 154)),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
