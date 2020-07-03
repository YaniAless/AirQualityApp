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

  static Stream<int> get temperature async*{
    Future.delayed(Duration(seconds: 10));
    final response = await http.get("$host/temp");

    if(response.statusCode != 200){
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    yield jsonBody;
  }

  static Stream<int> get humidity async*{
    Future.delayed(Duration(seconds: 10));
    final response = await http.get("$host/humidity");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    yield jsonBody;
  }

  static Future<int> getCO2Data() async {

    final response = await http.get("$host/co2");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);

    return jsonBody;
  }


  static Stream<int> get co2 async*{
    Future.delayed(Duration(seconds: 2));

    final response = await http.get("$host/co2");

    if(response.statusCode != 200){
      print(response.statusCode);
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    yield jsonBody;
  }

  static Stream<int> get tvoc async*{
    Future.delayed(Duration(seconds: 2));
    final response = await http.get("$host/tvoc");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    yield jsonBody;
  }
}