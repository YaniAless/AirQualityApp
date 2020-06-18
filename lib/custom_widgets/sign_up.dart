import 'package:airquality/app_localizations.dart';
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
                decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("email_placeholder")),
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if(value.isEmpty)
                    return AppLocalizations.of(context).translate("email_error_msg");
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
                  child: Text(AppLocalizations.of(context).translate("signing_up_button") , style: Theme.of(context).textTheme.button),
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
