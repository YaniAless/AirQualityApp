import 'dart:convert';

import 'package:airquality/pages/stats.dart';
import 'package:http/http.dart' as http;
import 'package:synchronized/synchronized.dart';
import 'package:intl/intl.dart';

class GetUserInfo {
  static String host = "http://192.168.1.14:8080";

  /// TODO A MODIFIER

  static Future<Map<String, dynamic>> getGeneral(
      String uid, DateTime startDate, DateTime endDate) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    try {
      final response = await http.get(
          "$host/users/$uid?startDate=${formatter.format(startDate)}&endDate=${formatter.format(endDate)}");
      if (response.statusCode != 200) {
        throw Error();
      }
      return json.decode(response.body);
    } catch (err) {
      print(err);
      print("Error while getting general data ");
      print(err);
    }
  }

  Future<List<UserInfoDetailed>> getByDate(
      String uid, DateTime begin, DateTime end, String sensor) async {
    var result = await getGeneral(uid, begin, end);

    List<UserInfoDetailed> uInfoList = List<UserInfoDetailed>();

    var lock = new Lock();

    await lock.synchronized(() async {
      if (begin.month == end.month) {
        result = {begin.month.toString(): result};
      }

      if (begin.year == end.year) {
        result = {begin.year.toString(): result};
      }

      result.forEach((_month, valY) {
        final Map<String, dynamic> months = (valY).cast<String, dynamic>();
        months.forEach((_month, valM) {
          final Map<String, dynamic> days = valM.cast<String, dynamic>();
          days.forEach((_day, valD) {
            final Map<String, dynamic> hours = valD.cast<String, dynamic>();
            hours.forEach((_hour, valH) {
              final Map<String, dynamic> sensorList =
                  valH.cast<String, dynamic>();

              uInfoList.add(UserInfoDetailed(
                  day: _day,
                  hour: _hour,
                  sensorValues: sensorList[sensor].toDouble()));
            });
          });
        });
      });
    });
    return uInfoList;
  }

  Future<Map<String, List<SensorData>>> getSensorValuesByDate(
      String uid, DateTime begin, DateTime end) async {
    var newSensor;
    Map<String, List<SensorData>> newResult = {
      "Temperature": new List<SensorData>(),
      "Humidity": new List<SensorData>(),
      "TVOC": new List<SensorData>(),
      "CO2": new List<SensorData>()
    };
    var test = ["Temperature", "Humidity", "CO2", "TVOC"];

    var lock = new Lock();

    await lock.synchronized(() async {
      for (var sensor in test) {
        switch (sensor) {
          case "Temperature":
            newSensor = "temperature";
            break;
          case "Humidity":
            newSensor = "humidity";
            break;
          case "CO2":
            newSensor = "co2";
            break;
          case "TVOC":
            newSensor = "tvoc";
            break;
        }
        var result = await getByDate(uid, begin, end, newSensor);
        result.forEach((userInfoDetailed) {
          newResult[sensor].add(
              SensorData(userInfoDetailed.day + "-" + userInfoDetailed.hour, userInfoDetailed.sensorValues));
        });
      }
    });
    return newResult;
  }
}

class UserInfoDetailed {
  String day;
  String hour;
  double sensorValues;

  UserInfoDetailed({this.day, this.hour, this.sensorValues});
}
