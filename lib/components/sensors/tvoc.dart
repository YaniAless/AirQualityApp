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
  final int refreshDelay = 3;

  // Sensor Data
  Sensor tvocSensor = Sensor();
  Timer timer;
  _fetchTVOC() {
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) async {
      int tvocValue = await ESPServices().getTVOC();
      ESP esp = Provider.of(context, listen: false);
      esp.setSensorsValue("TVOC", tvocValue);
      print(esp.sensors);
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
        tvocSensor.currentValue = esp.sensors["TVOC"];
        Widget icon = tvocSensor.evolutionIconSelector();
        tvocSensor.oldValue = tvocSensor.currentValue;
        return SensorDisplayer(
          cardColor: Colors.grey,
          sensorTitle: AppLocalizations.of(context).translate("tvoc_title"),
          sensorValue: tvocSensor.currentValue.toString(),
          sensorUnit: AppLocalizations.of(context).translate("tvoc_unit_short"),
          icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
          iconEvolution: AnimatedSwitcher(
            duration: Duration(seconds: 2),
            child: icon,
            transitionBuilder: (child, animation) {
              return ScaleTransition(child: child, scale: animation);
            },
          ),
        );
      },
    );
  }

  /*
  FutureBuilder<int>(
      future: tvoc,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return SensorDisplayer(
                cardColor: Colors.grey,
                sensorTitle:
                AppLocalizations.of(context).translate("tvoc_title"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("tvoc_unit_short"),
                icon: FaIcon(FontAwesomeIcons.cloud, size: 20),
                iconEvolution: AnimatedSwitcher(
                  duration: Duration(seconds: 2),
                  child: Icon(Icons.add),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(child: child, scale: animation);
                  },
                ),
              );
            }
            if(snapshot.hasError){
              return SensorDisplayer(
                cardColor: Colors.grey,
                sensorTitle:
                AppLocalizations.of(context).translate("tvoc_title"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.cloud, size: 20),
                iconEvolution: FaIcon(Icons.error,
                    color: Colors.red, size: 20),
              );
            }
            break;
        }
        return Container();
      },
    )
   */



}
