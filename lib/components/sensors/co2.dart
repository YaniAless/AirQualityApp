import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services_mock.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CO2Sensor extends StatefulWidget {
  @override
  _CO2SensorState createState() => _CO2SensorState();
}

class _CO2SensorState extends State<CO2Sensor> {

  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 5;

  // Sensor Data
  Sensor co2Sensor = Sensor();

  // Refreshing
  Timer timer;
  bool _firstLoad = true;
  bool _enableRefresh = true;

  refresh(bool enableRefresh){
     timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) {
       if(_enableRefresh){
         setState(() {
           _firstLoad = false;
           if(co2Sensor.oldValue != co2Sensor.currentValue)
             co2Sensor.oldValue = co2Sensor.currentValue;
         });
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: MockESPServices().getCO2(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              co2Sensor.currentValue = snapshot.data;
              Widget icon = co2Sensor.evolutionIconSelector();
              return SensorDisplayer(
                cardColor: Colors.grey,
                sensorTitle:
                AppLocalizations.of(context).translate("co2_title"),
                sensorValue: co2Sensor.currentValue.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("co2_unit_short"),
                icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
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
                cardColor: Colors.grey,
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
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _enableRefresh = false;
    timer.cancel();
    print(timer.isActive);
    print("deactivated => $_enableRefresh");
    super.dispose();
  }

  @override
  void initState() {
    if(_enableRefresh)
      refresh(_enableRefresh);
    super.initState();
  }
}
