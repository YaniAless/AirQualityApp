import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class GetUserInfo {

  Future<Map<String, dynamic>> getGeneral(String username) async {
    Response rawResponse = await http.get('http://localhost:8080/users/' + username);
    return jsonDecode(rawResponse.body);

  }

  Future<http.Response> getByDate(String username, DateTime begin, DateTime end) {
  }

  Future<http.Response> getMediumByDate(DateTime begin, DateTime end) {
  }

}