import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/co2.dart';
import 'package:airquality/components/sensors/tvoc.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    ESP esp = Provider.of<ESP>(context, listen: false);
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
                  AppLocalizations.of(context).translate("connected_to"),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<ESP>(
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
                      esp = snapshot.data;
                      return Text(esp.caseName);
                      break;
                    default:
                      return Container(
                          child: Text(AppLocalizations.of(context).translate("empty_device"))
                      );
                      break;
                  }
                },
                initialData: esp,
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
                  //TemperatureSensor(),
                  //HumiditySensor(),
                  CO2Sensor(),
                  TVOCSensor()
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}



