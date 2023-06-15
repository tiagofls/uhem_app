import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uhem_app/constants/Constants.dart';

import '../functions/Login.dart';
import '../functions/Patient.dart';
import '../functions/Travel.dart';
import '../functions/Utils.dart';
import '../models/Appointment.dart';
import '../models/Patient.dart';
import '../models/Travel.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/CardID.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/TravelTile.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class CuidadorHomeScreen extends StatefulWidget {
  const CuidadorHomeScreen({super.key});

  @override
  State<CuidadorHomeScreen> createState() => _CuidadorHomeScreenState();
}

class _CuidadorHomeScreenState extends State<CuidadorHomeScreen> {
 
String username = '';

  @override
  void initState() {
    super.initState();
    getCurrentCuidador();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatientCuidador(),
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
              AppTitleCuidador(context, 35, "Dashboard"),
              const SizedBox(
                height: 45,
              ),
              CardIDCuidador(context, p.data ?? pt, "Aurélio Buta"),
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
                                    Navigator.pushNamed(context, CuidadorDetailViewRoute);
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
                        colors: [Color.fromARGB(255, 49, 179, 255)],
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
                        Navigator.pushNamed(context, HistoryCuidadorScreenRoute);
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