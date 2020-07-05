import 'dart:async';
import 'dart:convert';

import 'package:airquality/models/esp.dart';
import 'package:airquality/services/ESP/interface_esp_service.dart';
import 'package:http/http.dart' as http;

class ESPServices implements ESPService{

  static final String host = "http://192.168.1.99:8080";

  @override
  Future<ESP> getSettings() async {

    final response = await http.get("$host/settings");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    List<String> sensorsList = (jsonBody["sensors"]).cast<String>();
    final ESP settings = ESP(caseName: jsonBody["caseName"], caseType: jsonBody["caseType"], sensors: sensorsList);

    return settings;
  }

  Future<int> getDataFromESPSensors(String path) async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host$path");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  Future<int> getCO2() async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host/co2");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  Future<int> getTVOC() async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host/tvoc");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  Future<double> getTemp() async {
    final response = await http.get("$host/temp");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);

    return jsonBody;
  }

  Future<int> getHumidity() async {
    final response = await http.get("$host/humidity");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }
}