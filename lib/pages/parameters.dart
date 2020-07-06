import 'package:airquality/app_localizations.dart';
import 'package:airquality/services/preferences/preferences.dart';
import 'package:flutter/material.dart';

class Parameters extends StatefulWidget {

  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.lightGreen[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppLocalizations.of(context).translate("params_page_label"),
                    style: TextStyle(
                      fontSize: 24,
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            children: <Widget>[
              ExpansionTile(
                title: Text("ESP parameters"),
                children: <Widget>[
                  ListTile(
                    leading: Text("IP Address : "),
                    title: FutureBuilder(
                      future: Preferences().getLocalIpParam(),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.done:
                            if(snapshot.hasData)
                              return TextFormField(
                                decoration: const InputDecoration(
                                  helperText: "Local IP Address of your ESP",
                                ),
                                initialValue: snapshot.data,

                                onChanged: (changedValue) => Preferences().updateLocalIpParam((changedValue)),
                              );
                            break;
                        }
                        return Container();
                      },
                    ),
                  ),
                  ListTile(
                    leading: Text("IP Port : "),
                    title: FutureBuilder(
                      future: Preferences().getLocalPortParam(),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.done:
                            if(snapshot.hasData)
                              return TextFormField(
                                decoration: const InputDecoration(
                                  helperText: "Local IP Port of your ESP",
                                ),
                                initialValue: snapshot.data.toString(),
                                onChanged: (changedValue) => Preferences().updateLocalPortParam((int.parse(changedValue))),
                              );
                            break;
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}