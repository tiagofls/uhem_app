import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/Constants.dart';
import '../widgets/AppTitle.dart';
import '../widgets/CardID.dart';
import '../widgets/RoadCarImage.dart';
import '../widgets/TravelTile.dart';
import '../widgets/ULink.dart';
import '../widgets/UText.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
     return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          SizedBox(height: getHeight(context)/25,),
          RoadCarImage(context),
          SizedBox(height: getHeight(context)/30),
          AppTitle(context, 35, "Dashboard"),
          const SizedBox(height: 45,),
          CardID(context),
          const SizedBox(height: 40,),
          UText("Próximas viagens", Colors.grey, FontWeight.w900, 18, TextAlign.start),
          const SizedBox(height: 20,),
          TravelTile(context),
          TravelTile(context),
          SizedBox(height: getHeight(context)/20,),
          ULink((){}, "Próximas Viagens", Colors.grey, 20)
        ],
      )
    );
  }
}