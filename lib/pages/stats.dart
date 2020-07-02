import 'package:airquality/components/sensors/sensor_label.dart';
import 'package:airquality/models/case.dart';
import 'package:flutter/material.dart';

class Statistiques extends StatelessWidget {

  final List<Case> cases = [
    Case("Case 1", 3),
    Case("Case 2", 4)
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
                  title: Text(cases[casesIndex].caseName, style: TextStyle(
                    fontSize: 24),
                  ),
                  subtitle: Text("Tap for more details"),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        LimitedBox(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: SensorLabel(
                                    sensorTitle: cases[casesIndex].sensors[index]),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cases[casesIndex].sensorNumber,

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

/*
SensorDisplayer(
                          cardColor: Colors.amber,
                          sensorTitle: "Temperature",
                          icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters, size: 25),
                        ),
                        SensorDisplayer(
                          cardColor: Colors.amber,
                          sensorTitle: "Temperature",
                          icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters, size: 25),
                        ),
                        SensorDisplayer(
                          cardColor: Colors.amber,
                          sensorTitle: "Temperature",
                          icon: FaIcon(FontAwesomeIcons.thermometerThreeQuarters, size: 25),
                        )
 */
