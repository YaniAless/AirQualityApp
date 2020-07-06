import 'package:airquality/app_localizations.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/esp_services_mock.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  ESP settings;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5,0,5,10),
              child: Container(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate("stats_page_label"), style: TextStyle(
                      fontSize: 40,
                    )),
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: MockESPServices().getSettings(),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
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
                            child: Text("Searching for a device..."),
                          ),
                          CircularProgressIndicator(),
                        ],
                      );
                      break;
                    case ConnectionState.done:
                      if(snapshot.hasData){
                        settings = snapshot.data;
                        return Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                              child: Text(settings.caseName, style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                              )),
                            ),
                            subtitle: ListView.builder(
                              itemCount: settings.sensors.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Text(settings.sensors[index]),
                                  subtitle: Text("Tap here for more details..."),
                                  children: <Widget>[
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
                                    Text("TOTOTOTTOOTTO"),
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
