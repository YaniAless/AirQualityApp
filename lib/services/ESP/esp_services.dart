import 'dart:convert';

import 'package:airquality/models/esp_settings.dart';
import 'package:http/http.dart' as http;

class ESPServices {

  String host = "http://192.168.4.1:8080";

  Future<ESP> getSettings() async {

    final response = await http.get("${this.host}/settings");

    if(response.statusCode != 200){
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    final ESP settings = ESP(caseName: jsonBody["caseName"], sensorsNumber: jsonBody["sensorsNumber"]);

    return settings;
  }
}