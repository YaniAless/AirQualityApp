import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:airquality/models/esp.dart';
import 'package:http/http.dart' as http;

class MockESPServices {

  static Future<int> getMockCO2() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(8000) + 10;
  }

  static Future<int> getMockTVOC() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(1000) + 10;
  }

  static Future<double> getMockTemp() async {
    Future.delayed(Duration(seconds: 2));
    double fakeValue = double.parse((Random.secure().nextInt(40) + 10).toString());
    return fakeValue;
  }

  static Future<int> getMockHumidity() async {
    Future.delayed(Duration(seconds: 2));
    return Random.secure().nextInt(100) + 10;
  }
}