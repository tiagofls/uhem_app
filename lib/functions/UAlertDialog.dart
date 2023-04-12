import 'package:flutter/material.dart';

Future<String?> UAlertDialog(BuildContext context, String title, String content){
   return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          contentTextStyle: const TextStyle(fontFamily: "Alegreya", color: Colors.black),
          titleTextStyle:  const TextStyle(fontFamily: "Alegreya", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Ok', style: TextStyle(color: Color(0xFF00C49A))),
            ),
          ],
        ),
    );
}