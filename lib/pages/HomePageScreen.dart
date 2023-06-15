import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/functions/Login.dart';
import 'package:uhem_app/functions/Patient.dart';
import 'package:uhem_app/models/Appointment.dart';
import 'package:uhem_app/models/Patient.dart';
import 'package:uhem_app/widgets/UText.dart';

import '../constants/Constants.dart';
import '../functions/Travel.dart';
import '../functions/Utils.dart';
import '../models/Travel.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/CardID.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/TravelTile.dart';
import '../widgets/ULink.dart';
import 'TravelDetailPage.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatient(),
      builder: (context, AsyncSnapshot<Patient> p) {
        return Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(context) / 25,
              ),
              RoadCarImage(context),
              SizedBox(height: getHeight(context) / 30),
              AppTitle(context, 35, "Dashboard"),
              const SizedBox(
                height: 45,
              ),
              CardID(context, p.data ?? pt),
              const SizedBox(
                height: 40,
              ),
              UText(
                "Próximas Consultas",
                Colors.grey,
                FontWeight.w900,
                18,
                TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: getHeight(context) / 3.5,
                child: SingleChildScrollView(
                  child: FutureBuilder<List<Appointment>>(
                    future:
                        getAppointment(), // Replace with your REST call to fetch travel data
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final travelList = snapshot.data!;
                        return Column(
                          children: travelList
                              .map(
                                (app) => GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('date', app.appointmentDate!.split(" ")[0]);
                                    prefs.setString('time', app.appointmentDate!.split(" ")[1]);
                                    prefs.setString('destination', app.idFacility.toString());
                                    prefs.setString('purpose', app.appointment.toString());
                                    prefs.setString('hasTravel', app.idTravel.toString());
                                    prefs.setString('id_appointment', app.id.toString());
                                    Navigator.pushNamed(context, DetailViewRoute);
                                  },
                                  child: TravelTile(
                                    context,
                                    app.appointmentDate!.split(" ")[0],
                                    app.appointment.toString(),
                                    app.nameFacility,
                                    app.appointmentDate!.split(" ")[1]
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('');
                      }
                      return const LoadingIndicator(
                        indicatorType: Indicator.ballClipRotatePulse,
                        colors: [Color.fromARGB(255, 26, 103, 76)],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context) / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: ULink(
                      () {
                        Navigator.pushNamed(context, HistoryScreenRoute);
                      },
                      "Histórico",
                      Colors.grey,
                      20,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(context) / 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle logout link click here
                      logout(context);
                    },
                    child: ULink(
                      () {
                        logout(context);
                      },
                      "Sair",
                      Colors.red,
                      20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
