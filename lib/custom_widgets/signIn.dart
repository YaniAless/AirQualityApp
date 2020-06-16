import 'package:airquality/firebase/authentication.dart';
import 'package:flutter/material.dart';

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
                decoration: const InputDecoration(hintText: "Enter your email"),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter your email';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter your password"),
                obscureText: true,
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter password';
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
                    //if(_formKey.currentState.validate())
                      // ok
                  },
                  child: Text("Connect" , style: Theme.of(context).textTheme.button),
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
