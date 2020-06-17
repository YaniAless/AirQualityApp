import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorDisplayer extends StatefulWidget {

  const SensorDisplayer({
    Key key,
    this.cardColor,
    this.sensorTitle,
    this.sensorValue,
    this.icon,
    this.iconEvolution
  }): super(key: key);

  final Color cardColor;
  final String sensorTitle;
  final String sensorValue;
  final Widget icon;
  final Widget iconEvolution;


  @override
  _SensorDisplayerState createState() => _SensorDisplayerState();
}

class _SensorDisplayerState extends State<SensorDisplayer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: widget.cardColor,
            child: ListTile(
              onTap: () {},
              title: Text(widget.sensorTitle, style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
              ),
              subtitle: Text(widget.sensorValue, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              )),
              leading: widget.icon,
              trailing: widget.iconEvolution,
            ),
          ),
        ),
      ],
    );
  }
}

/*
Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.bounceIn,
            color: Colors.amber,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width  / 3,
            height: MediaQuery.of(context).size.width  / 3,
            child: Text(widget.sensorValue, style: TextStyle(
                fontSize: 24,
                color: Colors.lightBlue
            )),
          ),
        )
 */
