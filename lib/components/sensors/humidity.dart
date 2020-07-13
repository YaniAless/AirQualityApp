import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HumiditySensor extends StatefulWidget {
  final esp;
  HumiditySensor({this.esp});

  @override
  _HumiditySensorState createState() => _HumiditySensorState();
}

class _HumiditySensorState extends State<HumiditySensor> {
  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 30;

  // Sensor Data
  Sensor humiditySensor = Sensor();

  // Refreshing
  Timer timer;

  _fetchHumidity() {
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) async {
      int humid = await ESPServices().getHumidity();
      ESP esp = Provider.of(context, listen: false);
      esp.setSensorsValue("Humidity", humid);
      //print(esp.sensors);
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
    _fetchHumidity();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ESP>(
      builder: (context, esp, child) {
        if(esp.sensors["Humidity"] == null){
          return SensorDisplayer(
          cardColor: Colors.lightBlueAccent,
          sensorTitle: AppLocalizations.of(context).translate("humidity_name"),
          sensorValue:
              AppLocalizations.of(context).translate("no_sensor_value"),
          sensorUnit: "",
          icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
          detailsRoute: "/humidityDetail",
          iconEvolution:
              FaIcon(Icons.error, color: Colors.red, size: iconEvolSize),
        );
      } else {
          humiditySensor.currentValue = esp.sensors["Humidity"];
          //Widget icon = humiditySensor.evolutionIconSelector();
          return SensorDisplayer(
            cardColor: Colors.lightBlueAccent,
            sensorTitle:
            AppLocalizations.of(context).translate("humidity_name"),
            sensorValue: humiditySensor.currentValue.toString(),
            sensorUnit: "%",
            detailsRoute: "/humidityDetail",
            icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
              /*iconEvolution: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: co2Sensor.evolutionIconSelector(),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
              )*/
          );
        }
      }
    );
  }
}