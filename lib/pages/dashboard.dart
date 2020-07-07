import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/co2.dart';
import 'package:airquality/components/sensors/humidity.dart';
import 'package:airquality/components/sensors/temperature.dart';
import 'package:airquality/components/sensors/tvoc.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/user.dart';
import 'package:airquality/services/ESP/esp_services.dart';
import 'package:airquality/services/firebase/sender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ESP esp;
  Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


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
                        esp = snapshot.data;
                      }
                      return Text(esp.caseName);
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
                if(esp != null && esp.sensors["Humidity"] != 0){
                  print("SENDER");
                  SenderService().sendData(user.email, esp.sensors["Temperature"], esp.sensors["Humidity"], esp.sensors["CO2"], esp.sensors["TVOC"]);
                }
                /*
                setState(() {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Refresh"),
                    backgroundColor: Colors.deepOrange,
                    duration: Duration(seconds: 2),
                  ));
                });
                */
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
                  TemperatureSensor(esp: esp),
                  HumiditySensor(esp: esp),
                  CO2Sensor(esp: esp),
                  TVOCSensor(esp: esp),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
