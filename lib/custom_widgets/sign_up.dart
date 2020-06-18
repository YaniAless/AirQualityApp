import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                    return 'Please enter some text';
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25,25,25,25),
                child: RaisedButton(
                  onPressed: () {
                    //if(_formKey.currentState.validate())
                    // ok
                  },
                  child: Text("Sign Up" , style: Theme.of(context).textTheme.button),
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
