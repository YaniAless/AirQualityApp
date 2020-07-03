import 'package:firebase_database/firebase_database.dart';

class SenderService {

  //Fonction qui permet de persister les informations sur Firebase, exemple :
  //SenderService().sendData("UserPhoneTest",  34.0, 3500.0, 420.0);
  void sendData(String username, double temperature, double co2, double tvoc) {
    DateTime dateNow = DateTime.now();
    final dbRef = FirebaseDatabase.instance.reference().child("Users/$username/${dateNow.year.toString()}/${dateNow.month.toString()}/${dateNow.day.toString()}/${dateNow.hour.toString()}/${dateNow.minute.toString()}");
    dbRef.set(<String, Object>{
      "temperature": temperature,
      "co2": co2,
      "tvoc": tvoc,
    }).then((r) => print("C'est envoyé ta mère"));
  }
}