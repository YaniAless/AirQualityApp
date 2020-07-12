import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/page_header.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/user.dart';
import 'package:airquality/services/API/get_user_info.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  ESP settings;

  Future _getSettings;
  Map<String, List<SensorData>> _getUserInfo = {
    "Temperature": null,
    "Humidity": null,
    "CO2": null,
    "TVOC": null
  };

  @override
  void initState() {
    _getSettings = ESPServices().getSettings();

    super.initState();
  }

  String _startDate = DateTime.now().toString();
  String _endDate = DateTime.now().toString();

  _handleDatePicker(String pickerChoice) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100))
        .then((pickedDate) {
      if (pickedDate != null) {
        String selectedDate =
            DateFormat('yyyy-MM-dd').format(pickedDate).toString();
        switch (pickerChoice) {
          case "start":
            setState(() {
              _startDate = selectedDate;
            });
            break;
          case "end":
            setState(() {
              _endDate = selectedDate;
            });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime exampleStartDate = DateTime.parse("2020-07-07");
    DateTime exampleEndDate = DateTime.parse("2020-07-09");
    final user = Provider.of<User>(context);
    return InkWell(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PageHeader(translationLabel: "stats_page_label"),
            FutureBuilder(
              future: _getSettings,
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
                                title: Text(
                                    settings.sensors.keys.elementAt(index)),
                                subtitle: Text(AppLocalizations.of(context)
                                    .translate("sensor_stats_hint")),
                                children: <Widget>[
                                  new FutureBuilder(
                                      future: GetUserInfo()
                                          .getSensorValuesByDate(user.uid,
                                              exampleStartDate, exampleEndDate),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Container();
                                            break;
                                          case ConnectionState.waiting:
                                            return CircularProgressIndicator();
                                            break;
                                          case ConnectionState.done:
                                            return SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              series: <
                                                  LineSeries<SensorData,
                                                      String>>[
                                                LineSeries<SensorData, String>(
                                                    dataSource: snapshot.data[
                                                        settings.sensors.keys
                                                            .elementAt(index)],
                                                    xValueMapper:
                                                        (SensorData sensor,
                                                                _) =>
                                                            sensor.hour,
                                                    yValueMapper:
                                                        (SensorData sensor,
                                                                _) =>
                                                            sensor.sensorValue,
                                                    // Enable data label
                                                    dataLabelSettings:
                                                        DataLabelSettings(
                                                            isVisible: true)),
                                              ],
                                            );
                                            break;
                                        }
                                        return Container();
                                      }),
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
/*
Card(
child: ListTile(
leading: Icon(Icons.calendar_today),
title: Text(_startDate),
onTap: _handleDatePicker("start"),
),
),
Card(
child: ListTile(
leading: Icon(Icons.calendar_today),
title: Text(_endDate),
onTap: _handleDatePicker("end"),
),
)*/

class SensorData {
  SensorData(this.hour, this.sensorValue);

  final String hour;
  final double sensorValue;
}
