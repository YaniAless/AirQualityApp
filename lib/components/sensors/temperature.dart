import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool _firstLoad = true;
  bool _enableRefresh = true;

  refresh(bool enableRefresh){
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) {
      if(_enableRefresh){
        setState(() {
          _firstLoad = false;
          tempSensor.oldValue = tempSensor.currentValue;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: ESPServices().getTemp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              double value = snapshot.data;
              tempSensor.currentValue = value.toInt();
              Widget icon = tempSensor.evolutionIconSelector();
              return SensorDisplayer(
                cardColor: Colors.amber,
                sensorTitle: AppLocalizations.of(context)
                    .translate("temperature_title"),
                sensorValue: tempSensor.currentValue.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("temperature_unit_short"),
                icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,
                    size: iconSize),
                iconEvolution: AnimatedSwitcher(
                  duration: Duration(seconds: 2),
                  child: icon,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(child: child, scale: animation);
                  },
                ),
              );
            }
            if(snapshot.hasError){
              return SensorDisplayer(
                cardColor: Colors.amber,
                sensorTitle: AppLocalizations.of(context)
                    .translate("temperature_title"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,
                    size: iconSize),
                iconEvolution: FaIcon(Icons.error,
                    color: Colors.red, size: iconEvolSize),
              );
            }
            break;
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _enableRefresh = false;
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if(_enableRefresh)
      refresh(_enableRefresh);
    super.initState();
  }
}


