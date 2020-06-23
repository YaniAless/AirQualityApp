import 'package:airquality/app_localizations.dart';
import 'package:airquality/models/user.dart';
import 'package:airquality/pages/dashboard.dart';
import 'package:airquality/pages/parameters.dart';
import 'package:airquality/pages/wrappers/account_wrapper.dart';
import 'package:airquality/pages/wrappers/stats_wrapper.dart';
import 'package:airquality/services/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const String appName = "Air Quality";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            buttonColor: Colors.lightGreen,
            textTheme: TextTheme(
              button: TextStyle(
                backgroundColor: Colors.lightGreen,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
        ),
        // List all of the app's supported locales here
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // THIS CLASS WILL BE ADDED LATER
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeListResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.first.languageCode &&
                supportedLocale.countryCode == locale.first.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        home: MyHomePage(title: appName),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final List<Widget> pages = [
    Dashboard(),
    StatsWrapper(),
    AccountWrapper(),
    Parameters()
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(AppLocalizations.of(context).translate("dashboard_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text(AppLocalizations.of(context).translate("stats_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(AppLocalizations.of(context).translate("account_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              title: Text(AppLocalizations.of(context).translate("params_page_label")),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        appBar: AppBar(
            centerTitle: true,
            title: Text("Air Quality"),
            backgroundColor: Colors.lightGreen,
            actions: <Widget>[
              user != null ? FlatButton.icon(
                  onPressed: () => AuthService().signOut(),
                  icon: FaIcon(FontAwesomeIcons.signOutAlt),
                  label: Text(AppLocalizations.of(context).translate("sign_out_button")))
                  : FaIcon(FontAwesomeIcons.globe)
            ]
        ),
        body: widget
            .pages[_currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
