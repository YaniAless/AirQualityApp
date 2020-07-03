import 'dart:async';
import 'dart:convert';

import 'package:airquality/models/esp.dart';
import 'package:http/http.dart' as http;

class ESPServices {

  static final String host = "http://192.168.4.1:8080";
  static final int port = 8080;


  static Future<ESP> getSettings() async {

    final response = await http.get("$host/settings");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    List<String> sensorsList = (jsonBody["sensors"]).cast<String>();
    final ESP settings = ESP(caseName: jsonBody["caseName"], caseType: jsonBody["caseType"], sensors: sensorsList);

    return settings;
  }

  static Future<int> getDataFromESPSensors(String path) async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host$path");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  static Future<int> getCO2() async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host/co2");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  static Future<int> getTVOC() async {
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host/tvoc");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }

  static Future<double> getTemp() async {
    final response = await http.get("$host/temp");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    return jsonBody;
  }

  static Future<int> getHumidity() async {
    final response = await http.get("$host/humidity");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    return jsonBody;
  }
}