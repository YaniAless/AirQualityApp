import 'dart:convert';

import 'package:http/http.dart' as http;


class GetUserInfo {

  static String host = "http://192.168.1.14:8080"; /// TODO A MODIFIER

  static Future<List<UserInfoDetailed>> getGeneral(String uid, DateTime startDate, DateTime endDate) async {
    try {
      final response = await http.get("$host/users/$uid");
      if(response.statusCode != 200){
        throw Error();
      }
      final jsonBody = json.decode(response.body);


        if(startDate.month == endDate.month){
          Map<String, dynamic> toto = {
            startDate.month.toString(): jsonBody
          };
          if(startDate.year == endDate.year){
            int year = startDate.year;
            int month = startDate.month;

            Map<String, dynamic> days = (jsonBody["$year"]["$month"]).cast<String, dynamic>();
            List<UserInfoDetailed> uInfoList;
            days.forEach((_day, valD) {
              final Map<String, dynamic> tempHours = valD.cast<String,dynamic>();
              tempHours.forEach((_hour, valH) {
                UserInfoDetailed infos = UserInfoDetailed(day: _day, hour: _hour, sensorValues: valH.cast<String,dynamic>());
                uInfoList.add(infos);
              });
            });
            return uInfoList;
        }
      }
    } catch(err){
      print("Error while getting general data ");
      print(err);
    }
  }

  Future<http.Response> getByDate(String username, DateTime begin, DateTime end) {
  }

  Future<http.Response> getMediumByDate(DateTime begin, DateTime end) {
  }

}

class UserInfoDetailed {
  String day;
  String hour;
  Map<String, dynamic> sensorValues;

  UserInfoDetailed({this.day, this.hour,this.sensorValues});
}