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
    this.iconEvolution,
    this.detailsRoute,
  }) : super(key: key);

  final Color cardColor;
  final String sensorTitle;
  final String sensorValue;
  final String sensorUnit;
  final Widget icon;
  final Widget iconEvolution;
  final String detailsRoute;

  @override
  _SensorDisplayerState createState() => _SensorDisplayerState();
}

class _SensorDisplayerState extends State<SensorDisplayer> {

  @override
  Widget build(BuildContext context) {
    return Card(

      color: widget.cardColor,
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(widget.detailsRoute),
        title: Text(
          widget.sensorTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        subtitle: Text("${widget.sensorValue} ${widget.sensorUnit}",
            style: TextStyle(
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
