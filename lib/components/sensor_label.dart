import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SensorLabel extends StatefulWidget {

  final String sensorTitle;
  final Widget icon;

  SensorLabel({Key key, this.sensorTitle, this.icon});

  @override
  _SensorLabelState createState() => _SensorLabelState();
}

class _SensorLabelState extends State<SensorLabel> {
  final Color cardColor = Colors.lightGreen;

  List<Widget> widgets = [Text("Test1"),Text("Test1"),Text("Test1")];

  bool displayWidgets = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        onTap: () {
          setState(() {
            displayWidgets = !displayWidgets;
          });
        },
        subtitle: Column(
          children: displayWidgets == false ? [] : widgets,
        ),
        title: Text(widget.sensorTitle, style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
        leading: widget.icon,
      ),
    );
  }
}
