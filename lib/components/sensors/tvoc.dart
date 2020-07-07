import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/models/sensor.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TVOCSensor extends StatefulWidget {
  final esp;
  TVOCSensor({this.esp});

  @override
  _TVOCSensorState createState() => _TVOCSensorState();
}

class _TVOCSensorState extends State<TVOCSensor> {

  final double iconSize = 30;
  final double iconEvolSize = 50;
  final int refreshDelay = 15;

  // Sensor Data
  Sensor TVOCSensor = Sensor();

  // Refreshing
  Timer timer;
  bool _firstLoad = true;
  bool _enableRefresh = true;

  refresh(bool enableRefresh){
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) {
      if(_enableRefresh){
        setState(() {
          _firstLoad = false;
          TVOCSensor.oldValue = TVOCSensor.currentValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: ESPServices().getTVOC(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              TVOCSensor.currentValue = snapshot.data;
              Widget icon = TVOCSensor.evolutionIconSelector();
              if(widget.esp != null)
                widget.esp.setSensorsValue("TVOC", TVOCSensor.currentValue);
              return SensorDisplayer(
                cardColor: Colors.grey,
                sensorTitle:
                AppLocalizations.of(context).translate("tvoc_title"),
                sensorValue: TVOCSensor.currentValue.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("tvoc_unit_short"),
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
                AppLocalizations.of(context).translate("tvoc_title"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
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
