import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SplashPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _name, _password,_topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 45.0),
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Text('Sign Up',
                      style:
                      TextStyle(fontSize: 75.0, fontFamily: 'GoogleSans',fontWeight: FontWeight.w500)),
                  SizedBox(width: 60.0),
                ],
              ),
              SizedBox(height: 50.0),
              TextFormField(
                style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  filled: true,
                  fillColor: Colors.white12,
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              TextFormField(
                style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),
                validator: (input) {
                  if (input.length < 3) {
                    return 'Enter a Valid Name';
                  }
                },
                onSaved: (input) => _name = input,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.white12,
                  suffixIcon: Icon(Icons.person_outline),
                ),
              ),
              TextFormField(
                style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),
                validator: (input) {
                  if (input.length < 6) {
                    return 'Longer password please';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white12,
                  suffixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(' Cancel ',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'GoogleSans',fontSize: 15.0)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => MySplashScreen()));},
                  ),
                  RaisedButton(
                    child: Text(' Sign Up ',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'GoogleSans',fontSize: 15.0)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: signUp,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser firebaseUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .setData({'name': _name});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MySplashScreen(user: firebaseUser)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
