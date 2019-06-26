import 'package:flutter/material.dart';
import 'package:news/Pages/HomePage.dart';
import 'SignUpPage.dart';
import 'TopicPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            children: <Widget>[
              SizedBox(height: 40.0),
              Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Text('Login',
                      style:
                      TextStyle(fontSize: 75.0, fontFamily: 'GoogleSans',fontWeight: FontWeight.w500)),
                  SizedBox(width: 100.0),
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
              SizedBox(height: 10.0),
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
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(' Cancel ',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'GoogleSans',fontSize: 15.0)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text(' Sign In ',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'GoogleSans',fontSize: 15.0)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: signUp,
                  ),
                ],
              ),
              FlatButton(
                child: Text('Not a user? Click here',
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
            ],
          )),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(user: user,
                )));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
