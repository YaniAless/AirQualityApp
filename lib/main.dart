import 'package:airquality/pages/dashboard.dart';
import 'package:airquality/pages/login.dart';
import 'package:airquality/pages/parameters.dart';
import 'package:airquality/pages/statistiques.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const String appName = "Air Quality";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.lightBlue,
        textTheme: TextTheme(
          button: TextStyle(
            backgroundColor: Colors.lightBlue,
            color: Colors.white,
            fontSize: 24,
          ),
        )
      ),
      home: MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final List<Widget> pages = [Dashboard(), Statistiques(), Login(), Parameters()];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text('Stats'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              title: Text('Parameters'),
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
        ),
        body: widget.pages[_currentIndex],// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
