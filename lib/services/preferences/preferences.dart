import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  Future<String> getLocalIpParam() async {
    final prefs = await SharedPreferences.getInstance();
    final localIp = prefs.getString("ESP_LOCAL_IP");
    if(localIp == null)
      return "192.168.1.99";
    return localIp;
  }

  Future<void> updateLocalIpParam(String ip) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ESP_LOCAL_IP", ip);
  }

  Future<int> getLocalPortParam() async {
    final prefs = await SharedPreferences.getInstance();
    final localIp = prefs.getInt("ESP_LOCAL_PORT");
    if(localIp == null)
      return 0;
    return localIp;
  }

  Future<void> updateLocalPortParam(int port) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("ESP_LOCAL_PORT", port);
  }

}