import 'package:flutter/material.dart';

class Saved extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        flexibleSpace: Center(
            child: new Text(
              "Saved Pages",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60.0, color: Colors.black),
            )),
      ),
      body: Center(
        child:Text("Saved Pages")
      ),
    );
  }

}