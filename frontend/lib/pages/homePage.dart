import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/signup.dart';

class IntroductionApp extends StatefulWidget {
  const IntroductionApp({super.key});

  @override
  State<IntroductionApp> createState() => _IntroductionAppState();
}

class _IntroductionAppState extends State<IntroductionApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Project',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35.0,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Image.asset('assets/image1.jpg'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                'Welcome to Project',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 24,
              ),
              Text(
                'A simple and secure way to store your personal data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade700),
                  ),
                  child: Text(
                    'Get Started!!!',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Not yet registered?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Click here',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )),
                ],
              )
            ],
          )),
        ));
  }
}
