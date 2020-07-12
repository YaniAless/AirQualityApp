import 'dart:async';
import 'dart:convert';

import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/interface_esp_service.dart';
import 'package:airquality/services/preferences/preferences.dart';
import 'package:http/http.dart' as http;

class ESPServices implements ESPService{

  Future<String> _retrieveHostAndPortInLocalPref() async{
    try{
      String ip = await Preferences().getLocalIpParam();
      int port = await Preferences().getLocalPortParam();
      String portAsStr = port.toString();

      if(ip != "" && portAsStr != "")
        return "http://$ip:$portAsStr";
      else
        return "http://192.168.1.99:8080";
    } catch(e){
      print(e);
      return "http://192.168.1.99:8080";
    }
  }

  @override
  Future<ESP> getSettings() async {
    try {
      final host = await _retrieveHostAndPortInLocalPref();
      final response = await http.get("$host/settings").timeout(Duration(seconds: 30));
      if(response.statusCode != 200){
        throw Error();
      }

      final jsonBody = json.decode(response.body);
      List<String> sensorsList = (jsonBody["sensors"]).cast<String>();
      Map<String, dynamic> sensorsMap = Map.fromIterable(sensorsList, key: (sensorName) => sensorName, value: (sensorName) => 0);

      ESP esp = ESP();
      esp.setESP(jsonBody["caseName"],jsonBody["caseType"],sensorsMap);
      return esp;
    } catch(err){
      print("Error while getting settings ");
    }
  }

  Future<int> getCO2() async {
    try {
      final host = await _retrieveHostAndPortInLocalPref();

      final response = await http.get("$host/co2");
      if(response.statusCode != 200){
        throw Error();
      }

      final jsonBody = json.decode(response.body);
      return jsonBody;
    } on Exception catch (e) {
      print("Error while getting CO2");
    }
  }

  Future<int> getTVOC() async {
    try {
      final host = await _retrieveHostAndPortInLocalPref();

      final response = await http.get("$host/tvoc");
      if(response.statusCode != 200){
        throw Error();
      }

      final jsonBody = json.decode(response.body);
      return jsonBody;
    } on Exception catch (e) {
      print("Error while getting TVOC");
    }
  }

  Future<double> getTemp() async {
    try {
      final host = await _retrieveHostAndPortInLocalPref();
      final response = await http.get("$host/temp");

      if(response.statusCode != 200){
        throw Error();
      }

      final jsonBody = json.decode(response.body);
      print(jsonBody);
      return jsonBody;
    } on Exception catch (e) {
      print("Error while getting Temperature");
    }
  }

  Future<int> getHumidity() async {
    try {
      final host = await _retrieveHostAndPortInLocalPref();
      final response = await http.get("$host/humidity");

      if(response.statusCode != 200){
        throw Error();
      }

      final jsonBody = json.decode(response.body);
      return jsonBody;
    } on Exception catch (e) {
      print("Error while getting Humidity");
    }
  }
}