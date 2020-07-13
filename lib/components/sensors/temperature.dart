import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TemperatureSensor extends StatefulWidget {
  @override
  _TemperatureSensorState createState() => _TemperatureSensorState();
}

class _TemperatureSensorState extends State<TemperatureSensor> {
  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 30;

  // Sensor Data
  Sensor tempSensor = Sensor();

  // Refreshing
  Timer timer;

  _fetchTemp() {
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) async {
      double temp = await ESPServices().getTemp();
      ESP esp = Provider.of(context, listen: false);
      esp.setSensorsValue("Temperature", temp);
    });
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _fetchTemp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ESP>(
      builder: (context, esp, child) {
        if (esp.sensors["Temperature"] == null) {
          return SensorDisplayer(
            cardColor: Colors.amber,
            sensorTitle:
                AppLocalizations.of(context).translate("temperature_title"),
            sensorValue:
                AppLocalizations.of(context).translate("no_sensor_value"),
            sensorUnit: "",
            icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,
                size: iconSize),
            detailsRoute: "/temperatureDetail",
            iconEvolution:
                FaIcon(Icons.error, color: Colors.red, size: iconEvolSize),
          );
        } else {
          double temp = esp.sensors["Temperature"];
          tempSensor.currentValue = temp.round();
          //Widget icon = tempSensor.evolutionIconSelector();
          return SensorDisplayer(
            cardColor: Colors.amber,
            sensorTitle:
            AppLocalizations.of(context).translate("temperature_title"),
            sensorValue: tempSensor.currentValue.toString(),
            sensorUnit: AppLocalizations.of(context)
                .translate("temperature_unit_short"),
            icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,
                size: iconSize),
            detailsRoute: "/temperatureDetail",
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
