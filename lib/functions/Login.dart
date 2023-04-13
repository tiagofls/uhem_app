// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/constants/UhemAPI.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> Login(BuildContext context, String sns, String code) async {
  if (await CheckLoginInputs(context, sns, code)) {
    if (await Authenticate(sns, code)) {
      return true;
    }
    UAlertDialog(context, invalidCred, invalidSnsOrCode);
    return false;
  } else {
    return false;
  }
}

Future<bool> CheckLoginInputs(
    BuildContext context, String sns, String code) async {
  String body = "";

  if (sns == "" || code == "") {
    if (sns == "") {
      body += "$missSns\n";
    }
    if (code == "") {
      body += missCode;
    }
    await UAlertDialog(context, obgFields, body);
  } else if (sns.length < 9) {
    body += invalidSns;
    await UAlertDialog(context, invalidCred, body);
  } else {
    return true;
  }
  return false;
}

Future<bool> Authenticate(String sns, String code) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url =
      "${baseUrl}LoginInfo/verify_pwd?sns=$sns&password=$code&flag=USER";

  var mUrl = Uri.parse(url);
  print(mUrl);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false") {
    return false;
  } else {
    return true;
  }
}

addStringToSF(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', username);
}

Future<bool> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('stringValue');
  return stringValue != null ? true : false;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("stringValue");
}
