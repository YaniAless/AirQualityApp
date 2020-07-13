import 'package:airquality/app_localizations.dart';
import 'package:airquality/components/sensors/detailed_pages/co2_detail.dart';
import 'package:airquality/components/sensors/detailed_pages/humidity_detail.dart';
import 'package:airquality/components/sensors/detailed_pages/temperature_detail.dart';
import 'package:airquality/components/sensors/detailed_pages/tvoc_detail.dart';
import 'package:airquality/models/esp.dart';
import 'package:airquality/models/user.dart';
import 'package:airquality/pages/dashboard.dart';
import 'package:airquality/pages/parameters.dart';
import 'package:airquality/pages/wrappers/account_wrapper.dart';
import 'package:airquality/pages/wrappers/stats_wrapper.dart';
import 'package:airquality/services/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main(){
  SyncfusionLicense.registerLicense("NT8mJyc2IWhia31hfWN9Z2doa3xmfGFjYWNzZGlmamlnYXMDHmg2PTAmPzYhY2MTOzwnPjI6P301IQ==");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const String appName = "Air Quality";
  static const String appVersion = "0.1.0";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.lightGreen[300],
          buttonColor: Colors.lightGreen[300],
          textTheme: TextTheme(
            button: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            headline1: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        // List all of the app's supported locales here
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        initialRoute: "/",
        routes: {
          "/co2Detail": (_) => CO2SensorDetail(),
          "/tvocDetail": (_) => TVOCSensorDetail(),
          "/temperatureDetail": (_) => TemperatureSensorDetail(),
          "/humidityDetail": (_) => HumiditySensorDetail(),
        },
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    Dashboard(),
    StatsWrapper(),
    AccountWrapper(),
    Parameters()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.lightGreen[50],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(AppLocalizations.of(context)
                  .translate("dashboard_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text(
                  AppLocalizations.of(context).translate("stats_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                  AppLocalizations.of(context).translate("account_page_label")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              title: Text(
                  AppLocalizations.of(context).translate("params_page_label")),
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
          title: Text(MyApp.appName),
          backgroundColor: Colors.lightGreen,
        ),
        body: ChangeNotifierProvider<ESP>(
          create: (context) => ESP(),
          child: pages[_currentIndex],
        ),
      ),
    );
  }
}
