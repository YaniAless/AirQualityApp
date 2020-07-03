import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CO2Sensor extends StatefulWidget {
  @override
  _CO2SensorState createState() => _CO2SensorState();
}

class _CO2SensorState extends State<CO2Sensor> {
  double iconSize = 30;
  double iconEvolSize = 50;

  // Sensor Data
  Future<int> currentValue = ESPServices.getCO2Data();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: currentValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return SensorDisplayer(
                cardColor: Colors.redAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("co2_title"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("co2_unit_short"),
                icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
                iconEvolution: FaIcon(FontAwesomeIcons.minus,
                    color: Colors.grey, size: iconEvolSize),
              );
            }
            if(snapshot.hasError){
              return SensorDisplayer(
                cardColor: Colors.redAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("co2_title"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
                iconEvolution: FaIcon(Icons.error,
                    color: Colors.grey, size: iconEvolSize),
              );
            }
            break;
        }
        return null;
      },
    );
  }
}


