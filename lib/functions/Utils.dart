import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

String getTime(String dateTimeString){

  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat.Hm().format(dateTime);
}

String getDate(String dateTimeString){
  
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);
  
  // Format the DateTime object to get the date as a string
  return dateTime.toString().split(' ')[0];
}

Future<Location> getLatLang(String placeName) async {

  List<Location> locations = await locationFromAddress(placeName);

  if (locations.isNotEmpty) {

    Location firstResult = locations.first;
    double latitude = firstResult.latitude;
    double longitude = firstResult.longitude;

    return Location(latitude: latitude, longitude: longitude, timestamp: DateTime.now());

  } else {
    throw Exception("Error searching for location");
  }
}

