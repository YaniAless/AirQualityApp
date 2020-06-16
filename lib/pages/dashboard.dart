
import 'package:airquality/custom_widgets/sensor_displayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

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
            Column(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SensorDisplayer(
                  sensorTitle: "Temperature",
                    sensorValue: "25°C"
                ),
                SensorDisplayer(
                  sensorTitle: "CO2",
                    sensorValue: "400"
                )
              ],
            ),
            Column(
              children: <Widget>[
                SensorDisplayer(
                  sensorTitle: "TVOC",
                  sensorValue: "500",
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
