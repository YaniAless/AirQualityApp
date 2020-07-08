import 'package:airquality/models/esp.dart';
import 'package:firebase_database/firebase_database.dart';

class SenderService {
  //Fonction qui permet de persister les informations sur Firebase, exemple :
  //SenderService().sendData("UserPhoneTest",  34.0, 3500.0, 420.0);
  void sendData(String username, double temperature, int humidity, int co2,
      int tvoc) async {
    DateTime dateNow = DateTime.now();
    print(dateNow.toUtc());
    final dbRef = FirebaseDatabase.instance.reference().child(
        "Users/$username/${dateNow.year.toString()}/${dateNow.month
            .toString()}/${dateNow.day.toString()}/${dateNow.hour
            .toString()}/${dateNow.minute.toString()}");
    dbRef
        .set(<String, Object>{
      "temperature": temperature,
      "humidity": humidity,
      "co2": co2,
      "tvoc": tvoc,
    })
        .then((r) => print("Sensors data have been sent"))
        .catchError((err) => print("Error while sending data $err"));
  }

  synchroData(String userName, ESP esp) {
    if (esp.isSensorsDataAvailable()) {
      final sensorsValues = esp.sensors;
      sendData(
          userName,
          sensorsValues["Temperature"],
          sensorsValues["Humidity"],
          sensorsValues["CO2"],
          sensorsValues["TVOC"]);
    } else {
      print("Can't start synchro");
    }
  }
}
