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
  bool _firstLoad = true;
  bool _enableRefresh = true;

  refresh(bool enableRefresh){
    timer = Timer.periodic(Duration(seconds: refreshDelay), (timer) {
      if(_enableRefresh){
        setState(() {
          _firstLoad = false;
          humiditySensor.oldValue = humiditySensor.currentValue;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    var esp = Provider.of<ESP>(context);

    return FutureBuilder<int>(
      future: ESPServices().getHumidity(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              humiditySensor.currentValue = snapshot.data;
              Widget icon = humiditySensor.evolutionIconSelector();

              return SensorDisplayer(
                cardColor: Colors.lightBlueAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("humidity_name"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: "%",
                icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
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
                cardColor: Colors.lightBlueAccent,
                sensorTitle:
                AppLocalizations.of(context).translate("humidity_name"),
                sensorValue: AppLocalizations.of(context).translate("no_sensor_value"),
                sensorUnit: "",
                icon: FaIcon(FontAwesomeIcons.water, size: iconSize),
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