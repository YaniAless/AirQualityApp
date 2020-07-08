import 'package:airquality/models/user.dart';
import 'package:airquality/pages/login.dart';
import 'package:airquality/pages/stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user != null ? Stats() : Login();
  }
}
