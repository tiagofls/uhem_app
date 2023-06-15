import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/Utils.dart';

import '../constants/Constants.dart';
import '../functions/Login.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/ULink.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../widgets/UText.dart';

class CuidadorDetailTravel extends StatefulWidget {

  const CuidadorDetailTravel({
    Key? key
  }) : super(key: key);

  @override
  State<CuidadorDetailTravel> createState() => _CuidadorDetailTravelState();
}

class CarRoute {
  final List<LatLng> routePoints;

  CarRoute({required this.routePoints});
}

class _CuidadorDetailTravelState extends State<CuidadorDetailTravel> {
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

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {}); // Trigger a rebuild after prefs is initialized
  }

  @override
  Widget build(BuildContext context) { return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(children: [
          SizedBox(
            height: getHeight(context) / 25,
          ),
          RoadCarImage(context),
          SizedBox(height: getHeight(context) / 100),
          AppTitleCuidador(context, 35, "Informações e Mapa"),
          const SizedBox(
            height: 45,
          ),
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
                        colors: [ Colors.blue],
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
            padding: EdgeInsets.only(left: getWidth(context) != null ? getWidth(context) / 6 : 40),
            child: SizedBox(
  width: getWidth(context) / 1.5,
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
                UText(prefs.getString('destination') ?? '', Colors.grey, FontWeight.w500, 19, TextAlign.start),
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
                UText((prefs.getString('time') ?? '') + " H", Colors.grey, FontWeight.w500, 19, TextAlign.start),
              ],
            ),
            SizedBox(height: 5),
        ],
      ),
      Column(
        children: [
            Row(
              children: [
                const Icon(CupertinoIcons.timer, size: 25, color: Colors.grey),
                SizedBox(width: getWidth(context) / 10),
                UText((prefs.getString('duration') ?? '') + " H", Colors.grey, FontWeight.w500, 19, TextAlign.start),
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
            height: getHeight(context) / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle history link click here
                  Navigator.pushNamed(context, CuidadorHomeRoute);
                },
                child: ULink(
                  () async {
                    Navigator.pushNamed(context, CuidadorHomeRoute);
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
}
