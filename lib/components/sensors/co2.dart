import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services_mock.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CO2Sensor extends StatefulWidget {
  @override
  _CO2SensorState createState() => _CO2SensorState();
}

class _CO2SensorState extends State<CO2Sensor> {
  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 2;

  // Sensor Data
  Sensor co2Sensor = Sensor(type: "CO2");

  // Refreshing
  Timer timer;

  _fetchCO2() {
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) async {
      int co2Value = await MockESPServices().getCO2();
      ESP esp = Provider.of(context, listen: false);
      co2Sensor.oldValue = co2Sensor.currentValue;
      esp.setSensorsValue("CO2", co2Value);
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
    _fetchCO2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ESP>(
        builder: (context, esp, child) {
          if(esp.sensors["CO2"] == null){
            return SensorDisplayer(
              cardColor: Colors.grey,
              sensorTitle:
              AppLocalizations.of(context).translate("co2_title"),
              sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
              sensorUnit: "",
              icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
              iconEvolution: FaIcon(Icons.error,
                  color: Colors.red, size: iconEvolSize),
            );
          } else {
            co2Sensor.currentValue = esp.sensors["CO2"];
            return SensorDisplayer(
              cardColor: Colors.grey,
              sensorTitle: AppLocalizations.of(context).translate("co2_title"),
              sensorValue: co2Sensor.currentValue.toString(),
              sensorUnit: AppLocalizations.of(context).translate("co2_unit_short"),
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
      ),
    );
  }
}