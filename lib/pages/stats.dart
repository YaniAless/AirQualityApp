import 'package:airquality/components/sensors/sensor_label.dart';
import 'package:airquality/models/esp.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  final List<ESP> cases = [
    ESP(caseName:"ESP1", caseType: "AQ1", sensors:["Temperature","Humidity","CO2","TVOC"]),
    ESP(caseName:"ESP2", caseType: "AQ1", sensors:["Temperature","Humidity","CO2","TVOC"])
  ];

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, casesIndex) {
          return Column(
            children: <Widget>[
              Card(
                child: ExpansionTile(
                  title: Text(
                    cases[casesIndex].caseName,
                    style: TextStyle(fontSize: 24),
                  ),
                  subtitle: Text("Tap for more details"),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        LimitedBox(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: SensorLabel(
                                    sensorTitle:
                                        cases[casesIndex].sensors[index]),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cases[casesIndex].sensors.length,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: cases.length,
      ),
    );
  }
}
