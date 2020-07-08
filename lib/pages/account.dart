import 'package:airquality/app_localizations.dart';
import 'package:airquality/models/user.dart';
import 'package:airquality/services/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Account extends StatelessWidget {

  Account({ this.user });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppLocalizations.of(context).translate("account_page_title"),
          style: TextStyle(
            fontSize: 25,
          ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text(user.email),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(DateFormat('yyyy-MM-dd HH:mm').format(user.creationDate.toLocal()).toString()),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(user.email),
              ),
            ],
          ),
        ),
        user != null ? FlatButton(
          onPressed: () => AuthService().signOut(),
          child: Text(AppLocalizations.of(context).translate("sign_out_button")),
        ) : null,
      ],
    );
  }
}
