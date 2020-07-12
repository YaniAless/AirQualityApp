import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sensor {

  final String type;

  Sensor({this.type});
  // Sensor Data
  int oldValue = 0;
  int currentValue = 0;

  double iconSize = 30;
  double iconEvolSize = 50;


  Widget evolutionIconSelector() {
    if(type == "TVOC" && type == "CO2"){
      print("$type => oldValue $oldValue");
      print("$type => current $currentValue");
    }
    if(currentValue != null){
      if (currentValue > oldValue) {
        oldValue = currentValue;
        return FaIcon(Icons.arrow_upward,
            color: Colors.green, size: iconEvolSize);
      }
      else if (currentValue < oldValue) {
        oldValue = currentValue;
        return FaIcon(Icons.arrow_downward,
            color: Colors.red, size: iconEvolSize);
      } else {
        return FaIcon(FontAwesomeIcons.minus,
            color: Colors.white, size: iconEvolSize);
      }
    } else {
      return FaIcon(Icons.error,
          color: Colors.red, size: iconEvolSize);
    }
  }
}