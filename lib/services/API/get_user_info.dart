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
    final DateFormat formatter = DateFormat('yyyy-MM-ddTH');
    try {
      final response = await http.get("$host/users/$uid?startDate=${formatter.format(startDate)}&endDate=${formatter.format(endDate)}");
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
                  day: _hour, hour: _hour, sensorValues: sensorList[sensor].toDouble()));
            });
          });
        });
      });
    });
    return uInfoList;
  }

  Future<List<SensorData>> getSensorValuesByDate(
      String uid, DateTime begin, DateTime end, String sensor) async {

    switch (sensor) {
      case "Temperature": sensor = "temperature";
      break;
      case "Humidity": sensor = "humidity";
      break;
      case "CO2": sensor = "co2";
      break;
      case "TVOC": sensor = "tvoc";
      break;
    }
    var result = await getByDate(uid, begin, end, sensor);
    List<SensorData> newResult = List<SensorData>();

    var lock = new Lock();

    await lock.synchronized(() async {
      result.forEach((userInfoDetailed) {
        newResult.add(
            SensorData(userInfoDetailed.hour, userInfoDetailed.sensorValues));
      });
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
