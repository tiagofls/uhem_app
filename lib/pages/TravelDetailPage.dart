import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/UAlertDialog.dart';
import 'package:uhem_app/functions/Utils.dart';
import 'package:uhem_app/widgets/UButton.dart';

import '../constants/Constants.dart';
import '../functions/Login.dart';
import '../functions/Travel.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/ULink.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../widgets/UText.dart';

class TravelDetailPage extends StatefulWidget {

  const TravelDetailPage({
    Key? key
  }) : super(key: key);

  @override
  State<TravelDetailPage> createState() => _TravelDetailPageState();
}

class CarRoute {
  final List<LatLng> routePoints;

  CarRoute({required this.routePoints});
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  late LatLng middlePoint;

  Future<CarRoute> getCarRoute(String placeName, String destiny) async {

    Location l = await getLatLang(placeName);
    Location ll = await getLatLang(destiny);
    LatLng start = LatLng(l.latitude, l.longitude);
    LatLng end = LatLng(ll.latitude, ll.longitude);

    
     this.middlePoint = LatLng(
  (start.latitude + end.latitude) / 2,
  (start.longitude + end.longitude) / 2,
);
    
      final url =
          'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
    final decodedData = json.decode(response.body);
    final route = decodedData['routes'][0];
    final geometry = route['geometry'];
    final List<PointLatLng> polylinePoints =
        PolylinePoints().decodePolyline(geometry);

    final routePoints = polylinePoints
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    return CarRoute(routePoints: routePoints);
  } else {
    throw Exception('Failed to load car route');
  }
    }

  late SharedPreferences prefs;
  late String hospital;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    hospital = await getFacilityName(prefs.getString('destination') ?? "12");
    setState(() {}); // Trigger a rebuild after prefs is initialized
  }

  @override
  Widget build(BuildContext context) { 
  List<String> carData = generateCarData(10);
  List<String> carCompany = ["Uber", "Bolt", "Lyft"];
    return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(children: [
          SizedBox(
            height: getHeight(context) / 25,
          ),
          RoadCarImage(context),
          SizedBox(height: getHeight(context) / 100),
          AppTitle(context, 35, "Informações e Mapa"),
          const SizedBox(
            height: 45,
          ),
          if(int.parse(prefs.getString('hasTravel') ?? "0") > int.parse("0"))... {
            SizedBox(
            height: getHeight(context) / 3.5,
            child: FutureBuilder<CarRoute>(
              future: getCarRoute(prefs.getString('home') ?? '', (prefs.getString('destination') ?? '') + ", Portugal"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final carRoute = snapshot.data!;
                  return FlutterMap(
                    options: MapOptions(
                      center: middlePoint,
                      zoom: 8
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        tileProvider: NonCachingNetworkTileProvider(),
                      ),
                      PolylineLayerOptions(
                        polylines: [
                          Polyline(
                            points: carRoute.routePoints,
                            color: Colors.blue,
                            strokeWidth: 3.0,
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading car route');
                } else {
                  return const LoadingIndicator(
                        indicatorType: Indicator.ballClipRotatePulse,
                        colors: [Color.fromARGB(255, 26, 103, 76)],
                      );
                }
              },
            ),
          ),
          SizedBox(
            height: getHeight(context) / 30,
          ),
          UText("Dados", Color.fromARGB(255, 107, 107, 107), FontWeight.bold, 25, TextAlign.start),
          SizedBox(
            height: getHeight(context) / 60,
          ),
          Padding(
            padding: EdgeInsets.only(left: getWidth(context) != null ? getWidth(context) / 5 : 40),
            child: SizedBox(
  width: getWidth(context) / 1.3,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.calendar, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText(prefs.getString('date') ?? '', Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.layers_alt_fill, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText(prefs.getString('purpose') ?? '', Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.map_pin_ellipse, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText(hospital, Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.clock, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText((formatTimePrev((prefs.getString('time') ?? '')) + " H") + "     Viagem", Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.clock_fill, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText((formatTime((prefs.getString('time') ?? '')) + " H") + "     Consulta", Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.building_2_fill, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText(carCompany[Random().nextInt(carCompany.length)], Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.car_detailed, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText(carData[Random().nextInt(10)], Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
    ],
  ),
),
          ),

          SizedBox(
            height: getHeight(context) / 250,
          )}
          else if(prefs.getString('hasTravel') == "0")...{
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: UText('Ainda não tem viagem marcada para esta consulta. Deseja agendar uma?', Colors.black, FontWeight.w400, 18, TextAlign.center),
                ),
                SizedBox(height: 10,),
                UButton(() async {
                  String id = await prefs.getString("id_appointment") ?? "";
                  if(await setCallTravel(id)){
                    await UAlertDialog(context, "Sucesso", "Irá ser contactado brevemente para finalizar o agendamento!");
                    Navigator.pushNamed(context, HomeViewRoute);
                  }
                  else UAlertDialog(context, "Erro", "Ocorreu um erro. Tente mais tarde!");
                }, "Agendar", Colors.white, const Color(0xFF156064), const StadiumBorder(), 
          20, FontWeight.w700, 4.0, const Color(0xFF00C49A))
              ],
              
            ),
            SizedBox(height: 30,)
          }
          else...{
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: UText('Recebemos o seu pedido de agendamente com sucesso! A instituição responsável, irá entrar em contacto consigo, brevemente.\n Obrigado!', Colors.black, FontWeight.w400, 18, TextAlign.center),
                ),
                
              ],
              
            ),
            SizedBox(height: 30,)
          },
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle history link click here
                  Navigator.pushNamed(context, HomeViewRoute);
                },
                child: ULink(
                  () async {
                    Navigator.pushNamed(context, HomeViewRoute);
                  },
                  "Voltar",
                  Colors.grey,
                  20,
                ),
              )
            ],
          ),
        ]));
  }

  String formatTime(String timeString) {
    String pattern = r'^(\d{2}:\d{2})';

    RegExp regex = RegExp(pattern);
    Match? match = regex.firstMatch(timeString);

    if (match != null) {
      String extractedTime = match.group(1)!;
      return extractedTime;
    } else
      return "";
  }

  String formatTimePrev(String timeString) {
  String pattern = r'^(\d{2}):(\d{2}):(\d{2})';

  RegExp regex = RegExp(pattern);
  Match? match = regex.firstMatch(timeString);

  if (match != null) {
    int hours = int.parse(match.group(1)!);
    int minutes = int.parse(match.group(2)!);

    // Subtract 2 hours from the original time
    hours = (hours - 2) % 24;

    String formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return formattedTime;
  } else {
    return "";
  }
}

  List<String> generateCarData(int length) {
  List<String> carBrands = ['Toyota', 'Honda', 'Ford', 'Chevrolet', 'BMW'];
  List<String> carModels = ['Camry', 'Civic', 'Mustang', 'Cruze', 'X5'];
  List<String> carData = [];

  Random random = Random();

  for (int i = 0; i < length; i++) {
    String brand = carBrands[random.nextInt(carBrands.length)];
    String model = carModels[random.nextInt(carModels.length)];
    String registrationPlate = generateRegistrationPlate(random);
    String carInfo = '$brand $model $registrationPlate';

    carData.add(carInfo);
  }

  return carData;
}

String generateRegistrationPlate(Random random) {
  String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String numbers = '0123456789';

  String plate = '';

  // Generate the first two letters
  plate += letters[random.nextInt(letters.length)];
  plate += letters[random.nextInt(letters.length)];

  // Generate the dash and next two numbers
  plate += '-';
  plate += numbers[random.nextInt(numbers.length)];
  plate += numbers[random.nextInt(numbers.length)];

  // Generate the last two letters
  plate += '-';
  plate += letters[random.nextInt(letters.length)];
  plate += letters[random.nextInt(letters.length)];

  return plate;
}
}
