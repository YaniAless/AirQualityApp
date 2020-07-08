import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TVOCSensor extends StatefulWidget {

  @override
  _TVOCSensorState createState() => _TVOCSensorState();
}

class _TVOCSensorState extends State<TVOCSensor> {

  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 2;

  // Sensor Data
  Sensor tvocSensor = Sensor(type: "TVOC");
  Timer timer;

  _fetchTVOC() {
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) async {
      int tvocValue = await ESPServices().getTVOC();
      ESP esp = Provider.of(context, listen: false);
      esp.setSensorsValue("TVOC", tvocValue);
    });
  }

  @override
  void dispose() {
    if(timer.isActive)
      timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _fetchTVOC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ESP>(
      builder: (context, esp, child) {
        if(esp.sensors["TVOC"] == null){
          return SensorDisplayer(
            cardColor: Colors.grey,
            sensorTitle:
            AppLocalizations.of(context).translate("tvoc_title"),
            sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
            sensorUnit: "",
            icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
            iconEvolution: FaIcon(Icons.error,
                color: Colors.red, size: iconEvolSize),
          );
        } else {
          tvocSensor.currentValue = esp.sensors["TVOC"];
          //Widget icon = tvocSensor.evolutionIconSelector();
          return SensorDisplayer(
            cardColor: Colors.grey,
            sensorTitle: AppLocalizations.of(context).translate("tvoc_title"),
            sensorValue: tvocSensor.currentValue.toString(),
            sensorUnit: AppLocalizations.of(context).translate("tvoc_unit_short"),
            icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
            /*iconEvolution: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: co2Sensor.evolutionIconSelector(),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
              )*/
          );
        }
      },
    );
  }



}
