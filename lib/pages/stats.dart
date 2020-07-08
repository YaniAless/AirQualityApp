import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/page_header.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats extends StatelessWidget {
  ESP settings;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PageHeader(translationLabel: "stats_page_label"),
            FutureBuilder(
              future: ESPServices().getSettings(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container(
                      child: Text("No settings..."),
                    );
                    break;
                  case ConnectionState.waiting:
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(AppLocalizations.of(context)
                              .translate("searching_for_device")),
                        ),
                        CircularProgressIndicator(),
                      ],
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      settings = snapshot.data;
                      return Card(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                            child: Text(settings.caseName,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ),
                          subtitle: ListView.builder(
                            itemCount: settings.sensors.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                title: Text(settings.sensors.keys.elementAt(index)),
                                subtitle: Text(AppLocalizations.of(context)
                                    .translate("sensor_stats_hint")),
                                children: <Widget>[
                                  SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    series: <LineSeries<SensorData, String>>[
                                      LineSeries<SensorData, String>(
                                          dataSource: <SensorData>[
                                            SensorData('Mon', 450),
                                            SensorData('Tue', 500),
                                            SensorData('Wed', 480),
                                            SensorData('Thu', 600),
                                            SensorData('Fri', 520)
                                          ],
                                          xValueMapper: (SensorData sensor, _) =>
                                              sensor.day,
                                          yValueMapper: (SensorData sensor, _) =>
                                          sensor.sensorValue,
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true)),
                                      LineSeries<SensorData, String>(
                                          dataSource: <SensorData>[
                                            SensorData('Mon', 1000),
                                            SensorData('Tue', 1000),
                                            SensorData('Wed', 1000),
                                            SensorData('Thu', 1000),
                                            SensorData('Fri', 1000)
                                          ],
                                          xValueMapper: (SensorData sensor, _) =>
                                          sensor.day,
                                          yValueMapper: (SensorData sensor, _) =>
                                          sensor.sensorValue,
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }
                    break;
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SensorData {
  SensorData(this.day, this.sensorValue);
  final String day;
  final double sensorValue;
}