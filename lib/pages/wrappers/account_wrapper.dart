import 'package:airquality/pages/account.dart';
import 'package:airquality/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:airquality/models/user.dart';

class AccountWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user != null ? Account(user: user) : Login();
  }
}
