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
  String DOB="01/01/2000";
  String gender= "male";
  String UID= '123456789012';
  String photo = 'assets/profile.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
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

                    ],
                  )
                ),
              ],
            ),
      ),
    );
  }
}
