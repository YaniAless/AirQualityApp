import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TVOCSensor extends StatefulWidget {
  @override
  _TVOCSensorState createState() => _TVOCSensorState();
}

class _TVOCSensorState extends State<TVOCSensor> {

  double iconSize = 30;
  double iconEvolSize = 50;

  // Sensor Data
  int currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: ESPServices.tvoc,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              print(snapshot.data);
              return SensorDisplayer(
                cardColor: Colors.grey,
                sensorTitle:
                AppLocalizations.of(context).translate("tvoc_title"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("tvoc_unit_short"),
                icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
                iconEvolution: FaIcon(Icons.arrow_downward,
                    color: Colors.red, size: iconEvolSize),
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
        return null;
      },
    );
  }
}
