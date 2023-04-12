import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:uhem_app/constants/Constants.dart';
import 'package:uhem_app/constants/UhemAPI.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';

Future<bool> Login(BuildContext context, String sns, String code) async{

  if(await CheckLoginInputs(context, sns, code)){
    if(await Authenticate(sns, code)){
      return true;
    }
    UAlertDialog(context, invalidCred, invalidSnsOrCode);
    return false;
  }
  else return false;
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

Future<bool> Authenticate(String sns, String code) async{
  var headers = {
    'accept': 'text/plain',
  };

  String url = "${baseUrl}LoginInfo/verify_pwd?sns=$sns&password=$code&flag=USER";

  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  
  if (res.body == "false") {
    return false;
  } else {
    return true;
  }
}
