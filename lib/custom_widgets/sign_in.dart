
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
                  onChanged: (value){
                    if(_isEmailValidated(value)) {
                      setState(() => email = value);
                    }else
                      print("Email not correct");
                  },
                  validator: (value) {
                    if(value.isEmpty && !_isEmailValidated(email))
                      return AppLocalizations.of(context).translate("email_error_msg");
                    return value;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("pwd_placeholder")),
                  textCapitalization: TextCapitalization.none,
                  obscureText: true,
                  onChanged: (pwd){
                    setState(() {
                      pwd = pwd;
                    });
                  },
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
                      print(email);
                      print(pwd);
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
