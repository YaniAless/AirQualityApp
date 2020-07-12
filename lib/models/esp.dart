

import 'package:airquality/services/ESP/esp_services.dart';
import 'package:flutter/material.dart';

class ESP with ChangeNotifier, ESPServices{
  String caseName = "";
  String caseType = "";
  Map<String, dynamic> sensors = {"Temperature": null, "Humidity":null,"CO2":null,"TVOC":null};

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

  replaceESPAndNotify(ESP _esp){
    if(_esp == null){
      print("ESP sent is null");
    } else {
      this.caseName = _esp.caseName;
      this.caseType = _esp.caseType;
      this.sensors = _esp.sensors;
      notifyListeners();
    }
  }

  Map<String, dynamic> get sensorData{
    return sensors;
  }

  bool isSensorsDataAvailable(){
    bool isAvailable = false;
    sensors.forEach((key, value) {
      if(value != null)
        isAvailable = true;
    });
    return isAvailable;
  }
}