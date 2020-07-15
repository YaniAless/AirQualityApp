import 'package:airquality/app_localizations.dart';
import 'package:flutter/material.dart';

class HumiditySensorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate("humidity_detail_page")),
      ),
      body: Center(
        child: InkWell(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)
                          .translate("humid_detail_title_1"),
                      style: TextStyle(
                        fontSize: 50,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_para_1")),
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_para_2"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen)),
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_para_3")),
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_para_4")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_title_2")),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("humid_detail_level_1"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen)),
                        TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("humid_detail_level_2"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate("humid_detail_title_3")),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        TextSpan(
                            text: AppLocalizations.of(context)
                                .translate("humid_detail_level_3")),
                      ],
                    ),
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Text(AppLocalizations.of(context).translate(
                            "humid_detail_level_4"),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(AppLocalizations.of(context).translate(
                              "humid_detail_level_5_infos")),
                        ),
                      ]),
                      TableRow(children: [
                        Text(AppLocalizations.of(context).translate(
                            "humid_detail_level_5"),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                              AppLocalizations.of(context).translate(
                                  "humid_detail_level_5_infos")),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
