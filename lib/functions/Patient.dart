import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/models/Patient.dart';

import '../constants/UhemAPI.dart';
import 'package:http/http.dart' as http;

Future<Patient> getPatient() async{
   var headers = {
    'accept': 'text/plain',
  };

  String sns = await getCurrentSns();


  String url =
      "${baseUrl}Patient?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false" || res.body.contains("xception")) {
      return Patient("","","","","","","");
  } else {
    var p  = Patient.fromJson(jsonDecode(res.body));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('home', "${p.address}, ${p.zipcode}, Portugal");
      return p;
  }
}

Future<Patient> getPatientCuidador() async{
   var headers = {
    'accept': 'text/plain',
  };

  String username = await getCurrentCuidador();

  String sns = await getAssoc(username);

  String url =
      "${baseUrl}Patient?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false" || res.body.contains("xception")) {
      return Patient("","","","","","","");
  } else {
    var p  = Patient.fromJson(jsonDecode(res.body));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('home', "${p.address}, ${p.zipcode}, Portugal");
      return p;
  }
}

Future<String> getAssoc(String username) async{
  var headers = {
    'accept': 'text/plain'
  };

  String url = "${baseUrl}LoginInfo/login-assoc?username=$username";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.body == "false" || res.body.contains("xception")) {
    return "";
  }
  else {
    return res.body;
  }
}