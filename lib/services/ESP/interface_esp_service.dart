import 'package:airquality/models/esp.dart';

abstract class ESPService{

  Future<ESP> getSettings();
  Future<int> getDataFromESPSensors(String path);
  Future<int> getCO2();
  Future<int> getTVOC();
  Future<double> getTemp();
  Future<int> getHumidity();
}