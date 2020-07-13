import 'package:airquality/app_localizations.dart';
import 'package:flutter/material.dart';

class TVOCSensorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("tvoc_detail_page")),
      ),
      body: Center(
        child: Text("Page detail"),
      ),
    );
  }
}
