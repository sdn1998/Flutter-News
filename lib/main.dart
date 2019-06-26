import 'package:flutter/material.dart';
import 'package:news/Pages/LoginPage.dart';
import 'package:news/Pages/HomePage.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
    theme: ThemeData(
      fontFamily: 'GoogleSans',
      buttonColor: Color.fromRGBO(45, 103, 170, 1),
      primaryColor: Color.fromRGBO(45, 103, 170, 1),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Login(),
        title: Text(
          'News',
          style: TextStyle(fontFamily: 'GoogleSans', fontSize: 50.0),
        ),
        loadingText: Text('Loading'),
        image: Image.asset(
          'images/logo.png',
        ),
        backgroundColor: Colors.white30,
        photoSize: 200.0,
        onClick: () => print("sdn"),
        loaderColor: Colors.blueGrey);
  }
}
