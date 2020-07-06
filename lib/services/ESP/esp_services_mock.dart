import 'dart:async';
import 'dart:math';

import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/interface_esp_service.dart';

class MockESPServices implements ESPService{



  Future<int> getCO2() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(8000) + 10;
  }

  Future<int> getTVOC() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(1000) + 10;
  }

  Future<double> getTemp() async {
    Future.delayed(Duration(seconds: 2));
    double fakeValue = double.parse((Random.secure().nextInt(35) + 10).toString());
    return fakeValue;
  }

  Future<int> getHumidity() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(100) + 10;
  }

  @override
  Future<int> getDataFromAllESPSensors() {
    // TODO: implement getDataFromESPSensors
    throw UnimplementedError();
  }

  @override
  Future<ESP> getSettings() async {
    ESP fakeESP = new ESP(caseName:"ESP1", caseType: "AQ1", sensors:["Temperature","Humidity","CO2","TVOC"]);
    return fakeESP;
  }
}