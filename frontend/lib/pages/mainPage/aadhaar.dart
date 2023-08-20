import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';

final Color favColor = Color(0xFF4C39C3);

class Aadhaar extends StatefulWidget {
  const Aadhaar({Key? key}) : super(key: key);

  @override
  State<Aadhaar> createState() => _AadhaarState();
}

class _AadhaarState extends State<Aadhaar> {
  String name = "John";
  String DOB = "01/01/2000";
  String gender = "male";
  String UID = '123456789012';
  String lion = 'assets/lion.png';
  String photo = 'assets/profile.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: favColor,
        centerTitle: true,
        title: Text('Aadhaar Card'),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            lion,
                            height: 60,
                          ),
                          Text(
                            "Government of India",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 6),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            photo,
                            height: 100,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(name),
                              Text('DOB: ${DOB}'),
                              Text(gender)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        UID,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                      color: Colors.red,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'My ', style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'AADHAAR',
                            style: TextStyle(color: Colors.red)),
                        TextSpan(
                            text: ', My Identity',
                            style: TextStyle(color: Colors.black))
                      ])),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
