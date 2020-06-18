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
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter your email';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter your password"),
                textCapitalization: TextCapitalization.none,
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
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Connected as anonymous"),
                          backgroundColor: Colors.deepOrange,
                          duration: Duration(seconds: 1),
                        )
                    );
                    //if(_formKey.currentState.validate())
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
