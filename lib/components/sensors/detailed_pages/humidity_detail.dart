import 'package:airquality/app_localizations.dart';
import 'package:flutter/material.dart';

class HumiditySensorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate("humidity_detail_page")),
      ),
      body: Center(
        child: Text("Page detail"),
      ),
    );
  }
}
