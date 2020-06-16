import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorDisplayer extends StatefulWidget {

  const SensorDisplayer({
    Key key,
    this.sensorTitle,
    this.sensorValue,
  }): super(key: key);

  final String sensorTitle;
  final String sensorValue;


  @override
  _SensorDisplayerState createState() => _SensorDisplayerState();
}

class _SensorDisplayerState extends State<SensorDisplayer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.sensorTitle, style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.bounceIn,
            color: Colors.amber,
            alignment: Alignment.center,
            width: 200,
            height: 200,
            child: Text(widget.sensorValue, style: TextStyle(
                fontSize: 24,
                color: Colors.lightBlue
            )),
          ),
        )
      ],
    );
  }
}
