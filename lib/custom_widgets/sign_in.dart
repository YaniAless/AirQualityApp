
import 'package:airquality/services/firebase/authentication.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("email_placeholder")),
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if(value.isEmpty)
                    return AppLocalizations.of(context).translate("email_error_msg");
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("pwd_placeholder")),
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                validator: (value) {
                  if(value.isEmpty)
                    return AppLocalizations.of(context).translate("pwd_error_msg");
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25,25,25,25),
                child: RaisedButton(
                  onPressed: () async {
                    dynamic result = await _auth.signInAnnon();
                    if(result == null)
                      print("Error signing in");
                    print("signed in $result");
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Connected as anonymous"),
                          backgroundColor: Colors.deepOrange,
                          duration: Duration(seconds: 1),
                        )
                    );
                    //if(_formKey.currentState.validate())
                  },
                  child: Text(AppLocalizations.of(context).translate("signing_in_button") , style: Theme.of(context).textTheme.button),
                  color: Theme.of(context).textTheme.button.backgroundColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
