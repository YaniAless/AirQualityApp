import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SensorLabelDetail extends StatefulWidget {
  @override
  _SensorLabelDetailState createState() => _SensorLabelDetailState();
}

class _SensorLabelDetailState extends State<SensorLabelDetail> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BarChart(
        BarChartData(
          backgroundColor: Colors.black26,
        )
      ),
    );
  }
}

