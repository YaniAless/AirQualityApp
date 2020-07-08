

import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';

class ESP with ChangeNotifier, ESPServices{
  String caseName = "";
  String caseType = "";
  Map<String, dynamic> sensors = {"Temperature": 0.0, "Humidity":0,"CO2":0,"TVOC":0};

  void setESP(String caseName, String caseType, Map<String, dynamic> sensors){
    this.caseName = caseName;
    this.caseType = caseType;
    this.sensors = sensors;
    notifyListeners();
  }

  void setSensorsValue(String sensorName, dynamic value){
    if(sensorName != "" && value != null){
      sensors[sensorName] = value;
      notifyListeners();
    }
  }

  Map<String, dynamic> get sensorData{
    return sensors;
  }
}