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
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade200,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          lion,
                          height: 100,
                        ),
                        Text("Government of India"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          photo,
                          height: 200,
                        ),
                        Column(
                          children: <Widget>[
                            Text(name),
                            Text('DOB: ${DOB}'),
                            Text(gender)
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(UID),
                    )
                  ],
                )),
            Divider(
              thickness: 2.0,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
