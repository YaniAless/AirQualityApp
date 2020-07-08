import 'package:airquality/app_localizations.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String translationLabel;

  PageHeader({this.translationLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.lightGreen[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              AppLocalizations.of(context)
                  .translate(translationLabel),
              style: TextStyle(
                fontSize: 24,
              )),
        ],
      ),
    );
  }
}
