// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/constants/UhemAPI.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/routes/RouterConstants.dart';

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

Future<bool> LoginCuidador(BuildContext context, String sns, String code) async {
  if (await CheckLoginInputs(context, sns, code)) {
    if (await AuthenticateCuidador(sns, code)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', sns);
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
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false") {
    return false;
  } else {
    addStringToSF(sns);
    return true;
  }
}

Future<bool> AuthenticateCuidador(String sns, String code) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url =
      "${baseUrl}LoginInfo/verify_pwd?sns=$sns&password=$code&flag=CUIDADOR";

  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false") {
    return false;
  } else {
    addStringToSF(sns);
    return true;
  }
}

addStringToSF(String sns) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('sns', sns);
}

Future<bool> getsnssSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? sns = prefs.getString('sns');
  return sns != null ? true : false;
}

Future<String> getCurrentSns() async {
  var prefs = await SharedPreferences.getInstance();
  String? sns = prefs.getString('sns');
  return sns ?? "";
}

Future<String> getCurrentCuidador() async {
  var prefs = await SharedPreferences.getInstance();
  String? sns = prefs.getString('username');
  return sns ?? "";
}

String getCurrentSnsAsString() {
  String sns = "";

  var sns2 = getCurrentSns();
  sns2.then((value) {
    sns = value;
  });

  return sns;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("sns");
}

logout(BuildContext context) {
  removeValues();
  Navigator.pushNamed(context, LoginViewRoute);
}

Future<bool> verifyGenerateAccessCode(String myToken, String username) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url =
      "${baseUrl}LoginInfo/verify_gen_ac?token=$myToken&username=$username";

  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false") {
    return false;
  } else {
    return true;
  }
}

Future<bool> GenerateToken(String sns, String username) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url = "${baseUrl}LoginInfo/token?sns=$sns&username=$username";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  print("Result: " + res.body + "->" + res.toString());
  if (res.body == "false" || res.body.contains("xception")) {
    return false;
  } else {
    return true;
  }
}

Future<bool> TokenCuidador(String email) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url = "${baseUrl}LoginInfo/token-cuidador?email=$email";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  if (res.body == "false" || res.body.contains("xception")) {
    return false;
  } else {
    return true;
  }
}

Future<bool> CuidadorVerifyToken(String username, String token, String password) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url = "${baseUrl}LoginInfo/verify-token-cuidador?username=$username&token=$token&password=$password";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  if (res.body == "false" || res.body.contains("xception")) {
    return false;
  } else {
    return true;
  }
}

Future<bool> AssocSns(String username, String sns) async {
  var headers = {
    'accept': 'text/plain',
  };

  String url = "${baseUrl}LoginInfo/set-sns?username=$username&sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  if (res.body == "false" || res.body.contains("xception")) {
    return false;
  } else {
    return true;
  }
}
