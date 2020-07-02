import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorDisplayer extends StatefulWidget {

  const SensorDisplayer({
    Key key,
    this.cardColor,
    this.sensorTitle,
    this.sensorValue,
    this.sensorUnit,
    this.icon,
    this.iconEvolution
  }): super(key: key);

  final Color cardColor;
  final String sensorTitle;
  final String sensorValue;
  final String sensorUnit;
  final Widget icon;
  final Widget iconEvolution;


  @override
  _SensorDisplayerState createState() => _SensorDisplayerState();
}

class _SensorDisplayerState extends State<SensorDisplayer> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      child: ListTile(
        onTap: () => print(widget.sensorTitle),
        title: Text(widget.sensorTitle, style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        ),
        subtitle: Text("${widget.sensorValue} ${widget.sensorUnit}", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        )),
        leading: widget.icon,
        trailing: widget.iconEvolution,
      ),
    );
  }
}

/*
ListTile(
              onTap: () => print(widget.sensorTitle),
              title: Text(widget.sensorTitle, style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              ),
              subtitle: Text("${widget.sensorValue} ${widget.sensorUnit}", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
              leading: widget.icon,
              trailing: widget.iconEvolution,
            )
 */

/*
Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: widget.cardColor,
            child: ListTile(
              onTap: () => print(widget.sensorTitle),
              title: Text(widget.sensorTitle, style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              ),
              subtitle: Text("${widget.sensorValue} ${widget.sensorUnit}", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
              leading: widget.icon,
              trailing: widget.iconEvolution,
            ),
          ),
        ),
      ],
    )
 */
