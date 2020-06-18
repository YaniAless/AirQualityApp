
import 'package:airquality/app_localizations.dart';
import 'package:airquality/custom_widgets/sensor_displayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {

  double iconSize = 30;
  double iconEvolSize = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(AppLocalizations.of(context).translate("dashboard_title"), style: TextStyle(
                  fontSize: 26,
                ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(AppLocalizations.of(context).translate("connected_to")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(AppLocalizations.of(context).translate("empty_device")),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Refresh"),
                    backgroundColor: Colors.deepOrange,
                    duration: Duration(seconds: 1),
                  )
                );
              },
              child: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Column(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SensorDisplayer(
                    cardColor: Colors.amber,
                    sensorTitle: AppLocalizations.of(context).translate("temperature_title"),
                    sensorValue: "25",
                    sensorUnit: AppLocalizations.of(context).translate("temperature_unit_short"),
                    icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters, size: iconSize),
                    iconEvolution: FaIcon(Icons.arrow_upward, color: Colors.green, size: iconEvolSize),
                  ),
                  SensorDisplayer(
                    cardColor: Colors.redAccent,
                    sensorTitle: AppLocalizations.of(context).translate("co2_title"),
                    sensorValue: "2000",
                    sensorUnit: AppLocalizations.of(context).translate("co2_unit_short"),
                    icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
                    iconEvolution: FaIcon(FontAwesomeIcons.minus, color: Colors.grey, size: iconEvolSize),
                  ),
                  SensorDisplayer(
                    cardColor: Colors.grey,
                    sensorTitle: AppLocalizations.of(context).translate("tvoc_title"),
                    sensorValue: "500",
                    sensorUnit: AppLocalizations.of(context).translate("tvoc_unit_short"),
                    icon: FaIcon(FontAwesomeIcons.cloud, size: iconSize),
                    iconEvolution: FaIcon(Icons.arrow_downward, color: Colors.red, size: iconEvolSize),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
