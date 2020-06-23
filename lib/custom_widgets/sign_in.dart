
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

  //Text fields
  String email = "";
  String pwd = "";

  _isEmailValidated(String email){
    return email.contains(new RegExp(r'[a-z0-9A-Z-.]+1*@[a-zA-Z]+\.[a-z]+'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: LimitedBox(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("email_placeholder")),
                  textCapitalization: TextCapitalization.none,
                  validator: (email) {
                    if(email.isEmpty || !_isEmailValidated(email))
                      return AppLocalizations.of(context).translate("email_error_msg");
                    email = email;
                    return null;
                  },
                  onSaved:(emailValue) => setState(() => email = emailValue),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("pwd_placeholder")),
                  textCapitalization: TextCapitalization.none,
                  obscureText: true,
                  validator: (pwd) {
                    if(pwd.isEmpty)
                      return AppLocalizations.of(context).translate("pwd_error_msg");
                    return null;
                  },
                  onSaved:(pwdValue) => setState(() => pwd = pwdValue),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25,25,25,25),
                  child: RaisedButton(
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        print(email);
                        print(pwd);
                      }
                    },
                    child: Text(AppLocalizations.of(context).translate("signing_in_button") , style: Theme.of(context).textTheme.button),
                    color: Theme.of(context).textTheme.button.backgroundColor,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
