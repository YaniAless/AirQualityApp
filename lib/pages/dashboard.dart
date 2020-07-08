import 'dart:async';

import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/page_header.dart';
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
  Timer timer;
  _sendSensorsData(){
    timer = Timer.periodic(Duration(seconds:35,minutes: 0), (timer) {
      try{
        final user = Provider.of<User>(context, listen: false);
        ESP esp = Provider.of<ESP>(context, listen: false);

        if(user != null && esp.isSensorsDataAvailable()) {
          SenderService().synchroData(user.uid, esp);
        }
        if(user == null){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 15),
              content: Text(AppLocalizations.of(context).translate("not_connected_msg")),
              backgroundColor: Colors.deepOrangeAccent,
            )
          );
        }
      } catch(err){
        print("Could not send data");
      }
    });
  }
  @override
  void initState() {
    _sendSensorsData();
    super.initState();
  }

  @override
  void dispose() {
    if(timer.isActive)
      timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ESP esp = Provider.of<ESP>(context, listen: false);
    return Column(
      children: <Widget>[
        PageHeader(translationLabel: "dashboard_title"),
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
                    case ConnectionState.none:
                      return Container(
                          child: Text(AppLocalizations.of(context).translate("empty_device"))
                      );
                      break;
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                      break;
                    case ConnectionState.done:
                      if(snapshot.hasData){
                        esp = snapshot.data;
                        return Text(esp.caseName);
                      }
                      if (snapshot.hasError || esp == null){
                        return Container(
                            child: Text(AppLocalizations.of(context).translate("empty_device"))
                        );
                      }
                      return Container(
                          child: Text(AppLocalizations.of(context).translate("empty_device"))
                      );
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CO2Sensor(),
                  TVOCSensor(),
                  TemperatureSensor(),
                  HumiditySensor(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}



