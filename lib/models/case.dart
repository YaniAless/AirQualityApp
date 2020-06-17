import 'package:flutter/material.dart';

class Case {
  String caseName;
  int sensorNumber;
  List sensors;

  Case(String caseName, int sensorNumber){
    this.caseName = caseName;
    this.sensorNumber = sensorNumber;
    this.sensors = new List(sensorNumber);
    switch(sensorNumber){
      case 3:
        sensors = ["CO2", "TVOC", "Temperature"];

      break;
      case 4:
        sensors = ["CO2", "TVOC", "Temperature", "Humidity"];
      break;
      default:
        print("Error");
        break;
    }
  }
}