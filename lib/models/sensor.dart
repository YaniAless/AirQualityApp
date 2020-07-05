import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sensor {

  // Sensor Data
  int oldValue = 0;
  int currentValue = 0;

  double iconSize = 30;
  double iconEvolSize = 50;

  Widget evolutionIconSelector() {
    if (currentValue > oldValue) {
      return FaIcon(Icons.arrow_upward,
          color: Colors.green, size: iconEvolSize);
    }
    else if (currentValue < oldValue) {
      return FaIcon(Icons.arrow_downward,
          color: Colors.red, size: iconEvolSize);
    } else {
      return FaIcon(FontAwesomeIcons.minus,
          color: Colors.white, size: iconEvolSize);
    }
  }
}