import 'dart:convert';

import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/models/Patient.dart';

import '../constants/UhemAPI.dart';
import 'package:http/http.dart' as http;

import '../models/Appointment.dart';
import '../models/Travel.dart';

Future<List<Travel>> getTravel() async {
  var headers = {
    'accept': 'application/json',
  };

  String sns = "123456789";

  String url = "${baseUrl}Travel?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);


  if (res.statusCode == 200) {
    try {
      List<dynamic> jsonData = json.decode(res.body);
      List<Travel> travels = jsonData.map((json) => Travel.fromJson(json)).toList();
      return travels;
    } catch (e) {
      return []; // Return an empty list in case of an error
    }
  } else {
    return []; // Return an empty list in case of an error
  }
}

Future<bool> setCallTravel(String id) async{
  var headers = {
    'accept': 'application/json',
  };

  String url = "${baseUrl}Travel/set-travel-call?id=$id";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.statusCode == 200) {
    return true;
  }
  else {
    return false;
  }
}

Future<String> getFacilityName(String id) async{
  var headers = {
    'accept': 'application/json',
  };

  String sns = "123456789";

  String url = "${baseUrl}HealthFacility/id?id=$id";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.statusCode == 200) {
    try {
      Map<String, dynamic> jsonData = json.decode(res.body);
      String facilityName = jsonData['name'];
      return facilityName;
    } catch (e) { 
      print('Error: $e'); // Print the error for debugging purposes
      return ""; // Return an empty string in case of an error
    }
  } else {
    print('Request failed with status: ${res.statusCode}'); // Print the error for debugging purposes
    return ""; // Return an empty string in case of an error
  }
  
}

Future<List<Appointment>> getAppointment() async {
  var headers = {
    'accept': 'application/json',
  };
  print("getAppointment");
  String sns = "123456789";

  String url = "${baseUrl}Travel/appointments?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);
  if (res.statusCode == 200) {
    try {
      List<dynamic> jsonData = json.decode(res.body); 
      List<Appointment> travels = List<Appointment>.from(jsonData.map((x) => Appointment.fromJson(x)));
      
      for (var i = 0; i < travels.length; i++) {
        var facName = await getFacilityName(travels[i].idFacility.toString());
        travels[i].nameFacility = facName;
      }

      return travels;
    } catch (e) {
      return []; // Return an empty list in case of an error
    }
  } else {
    return []; // Return an empty list in case of an error
  }
}

Future<List<Appointment>> getPreviousAppointment() async {
  var headers = {
    'accept': 'application/json',
  };

  String sns = "123456789";

  String url = "${baseUrl}Travel/previous-appointment?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);


  if (res.statusCode == 200) {
    try {
      List<dynamic> jsonData = json.decode(res.body);
      List<Appointment> travels = jsonData.map((json) => Appointment.fromJson(json)).toList();
      return travels;
    } catch (e) {
      return []; // Return an empty list in case of an error
    }
  } else {
    return []; // Return an empty list in case of an error
  }
}

Future<List<Travel>> getPreviousTravel() async {
  var headers = {
    'accept': 'application/json',
  };

  String sns = await getCurrentSns();

  String url = "${baseUrl}Travel/previous?sns=$sns";
  var mUrl = Uri.parse(url);
  var res = await http.get(mUrl, headers: headers);

  if (res.statusCode == 200) {
    try {
      List<dynamic> jsonData = json.decode(res.body);

      List<Travel> travels = jsonData.map((json) => Travel.fromJson(json)).toList();

      return travels;
    } catch (e) {
      return []; // Return an empty list in case of an error
    }
  } else {
    return []; // Return an empty list in case of an error
  }
}



Future<String> getRestItem(String urL) async {
  var headers = {
    'accept': 'application/json',
  };

  String url = baseUrl + urL;

  var response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}


