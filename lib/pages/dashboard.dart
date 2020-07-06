import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/co2.dart';
import 'package:airquality/components/sensors/humidity.dart';
import 'package:airquality/components/sensors/temperature.dart';
import 'package:airquality/components/sensors/tvoc.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic settings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.lightGreen[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context).translate("dashboard_title"),
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                    AppLocalizations.of(context).translate("connected_to")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: ESPServices().getSettings(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasError){
                        return Container(
                            child: Text(AppLocalizations.of(context).translate("empty_device"))
                        );
                      }
                      if (snapshot.hasData) {
                        settings = snapshot.data;
                      }
                      return Text(settings.caseName);
                      break;
                    default:
                      return Container(
                          child: Text(AppLocalizations.of(context).translate("empty_device"))
                      );
                      break;
                  }
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Refresh"),
                    backgroundColor: Colors.deepOrange,
                    duration: Duration(seconds: 2),
                  ));
                });
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
                  TemperatureSensor(),
                  HumiditySensor(),
                  CO2Sensor(),
                  TVOCSensor(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
