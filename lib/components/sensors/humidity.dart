import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HumiditySensor extends StatefulWidget {
  @override
  _HumiditySensorState createState() => _HumiditySensorState();
}

class _HumiditySensorState extends State<HumiditySensor> {
  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 30;

  // Sensor Data
  int currentValue;
  bool firstLoad = true;

  refresh(){
    Timer.periodic(Duration(seconds: refreshDelay), (timer) {
      setState(() {
        firstLoad = false;
      });
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: ESPServices.getHumidity(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return SensorDisplayer(
                cardColor: Colors.lightBlueAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("humidity_name"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: "%",
                icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
                iconEvolution: FaIcon(Icons.arrow_upward,
                    color: Colors.green, size: iconEvolSize),
              );
            }
            if(snapshot.hasError){
              return SensorDisplayer(
                cardColor: Colors.lightBlueAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("humidity_name"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
                iconEvolution: FaIcon(Icons.error,
                    color: Colors.green, size: iconEvolSize),
              );
            }
            break;
        }
        return null;
      },
    );
  }
}