import 'package:airquality/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TVOCSensorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("tvoc_detail_page")),
      ),
      backgroundColor: Colors.lightGreen[50],
      body: InkWell(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("What is TVOC ?",
                      style: TextStyle(
                        fontSize: 50,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          TextSpan(text: "\nTVOC is the "),
                          TextSpan(
                              text: "Total of Volatile Organic Compounds.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen)),
                          TextSpan(
                              text:
                                  "\nThis is a mix a multiple organic chemicals that evaporates at low temperatures."),
                          TextSpan(text: "\nThese chemicals are everywhere, "),
                          TextSpan(
                              text:
                                  "\nwhen you smell the famous 'new car odour' or even gasoline at a gas station this is not always a good thing"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "What these Volatile Organic Compounds levels mean ?"),
                        ],
                      ),
                    ),
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Text("0-250 ppb",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text("VOC content in air is low"),
                        ),
                      ]),
                      TableRow(children: [
                        Text("250 to 2000 ppb",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                              "Ventilate if levels persist for at least a month, and seek sources."),
                        ),
                      ]),
                      TableRow(children: [
                        Text("> 2000 ppb",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                              "The VOC content is very high, remember to take the necessary measures and ventilate without further delay."),
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

/*
Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("0-250 ppb", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                              Text("250 to 2000 ppb", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                              Text("> 2000 ppb", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("VOC content in air is low"),
                              Text("Ventilate if levels persist for at least a month, and seek sources."),
                              Text("The VOC content is very high, remember to take the necessary measures and ventilate without further delay."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
 */