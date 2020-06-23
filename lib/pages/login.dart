import 'package:airquality/custom_widgets/sign_in.dart';
import 'package:airquality/custom_widgets/sign_up.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: RaisedButton(
                  onPressed: () => setState(() => isSigningUp = false),
                  child: Text(AppLocalizations.of(context).translate("sign_in_button"), style: Theme.of(context).textTheme.button),
                  color: Theme.of(context).textTheme.button.backgroundColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: RaisedButton(
                  onPressed: () => setState(() => isSigningUp = true),
                  child: Text(AppLocalizations.of(context).translate("sign_up_button") , style: Theme.of(context).textTheme.button),
                  color: Theme.of(context).textTheme.button.backgroundColor,
                ),
              ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,50,20,20),
            child: isSigningUp == false ? SignIn() : SignUp(),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(35),
              child: Text(AppLocalizations.of(context).translate("not_connected_msg"), style: TextStyle(
                fontSize: 20,
                color: Colors.pink,
              ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
