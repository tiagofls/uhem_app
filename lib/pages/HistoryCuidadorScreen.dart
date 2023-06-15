import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:uhem_app/functions/Patient.dart';
import 'package:uhem_app/models/Patient.dart';

import '../constants/Constants.dart';
import '../functions/Login.dart';
import '../functions/Travel.dart';
import '../functions/Utils.dart';
import '../models/Travel.dart';
import '../routes/RouterConstants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/CardID.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/TravelTile.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class HistoryCuidadorScreen extends StatefulWidget {
  const HistoryCuidadorScreen({super.key});

  @override
  State<HistoryCuidadorScreen> createState() => _HistoryCuidadorScreenState();
}

class _HistoryCuidadorScreenState extends State<HistoryCuidadorScreen> {
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
                "Histórico",
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
                  child: FutureBuilder<List<Travel>>(
                    future:
                        getPreviousTravel(), // Replace with your REST call to fetch travel data
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final travelList = snapshot.data!;
                        return Column(
                          children: travelList
                              .map(
                                (travel) => GestureDetector(
                                  onTap: () {},
                                  child: TravelTile(
                                    context,
                                    getDate(travel.dateTravel!),
                                    travel.idTravelPurpose.toString(),
                                    travel.idFacility.toString(),
                                    ""
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
                      // Handle history link click here
                      Navigator.pushNamed(context, CuidadorHomeRoute);
                    },
                    child: ULink(
                      () {
                        Navigator.pushNamed(context, CuidadorHomeRoute);
                      },
                      "Próximas Viagens",
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
