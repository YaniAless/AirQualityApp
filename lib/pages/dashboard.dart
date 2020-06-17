
import 'package:airquality/custom_widgets/sensor_displayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {

  double iconSize = 50;

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
                child: Text("Realtime data", style: TextStyle(
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
                child: Text("Connected to :"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text("DEVICE_NAME"),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              onPressed: (){},
              color: Colors.lightBlue,
              child: Icon(
                Icons.refresh,
                color: Colors.amber,
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
                    sensorTitle: "Temperature",
                    sensorValue: "25°C",
                    icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters),
                    iconEvolution: FaIcon(Icons.arrow_upward, color: Colors.green, size: iconSize),
                  ),
                  SensorDisplayer(
                    sensorTitle: "CO2",
                    sensorValue: "2000",
                    icon: FaIcon(FontAwesomeIcons.cloud),
                    iconEvolution: FaIcon(FontAwesomeIcons.minus, color: Colors.grey, size: iconSize),
                  ),
                  SensorDisplayer(
                    sensorTitle: "TVOC",
                    sensorValue: "500",
                    icon: FaIcon(FontAwesomeIcons.cloud),
                    iconEvolution: FaIcon(Icons.arrow_downward, color: Colors.red, size: iconSize),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
