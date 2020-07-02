import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/sensor_displayer.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TemperatureSensor extends StatefulWidget {



  @override
  _TemperatureSensorState createState() => _TemperatureSensorState();
}

class _TemperatureSensorState extends State<TemperatureSensor> {

  double iconSize = 30;
  double iconEvolSize = 50;

  // Sensor Data
  int currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: ESPServices.temperature,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return SensorDisplayer(
                cardColor: Colors.amber,
                sensorTitle: AppLocalizations.of(context)
                    .translate("temperature_title"),
                sensorValue: snapshot.data.toString(),
                sensorUnit: AppLocalizations.of(context)
                    .translate("temperature_unit_short"),
                icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,
                    size: iconSize),
                iconEvolution: FaIcon(Icons.arrow_upward,
                    color: Colors.green, size: iconEvolSize),
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
        return null;
      },
    );
  }
}


