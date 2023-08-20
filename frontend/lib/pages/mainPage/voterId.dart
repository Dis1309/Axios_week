import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';

class VoterId extends StatefulWidget {
  const VoterId({Key? key}) : super(key: key);

  @override
  State<VoterId> createState() => _VoterIdState();
}

final Color favColor = Color(0xFF4C39C3);

class _VoterIdState extends State<VoterId> {
  dynamic UID = "435345344333";
  String name = "John Doe";
  String DOB = '01-01-2000';
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('VoterId'),
        centerTitle: true,
        backgroundColor: favColor,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/voter.png"),
                ),
              ),
              child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(
                        0,
                        MediaQuery.of(context).size.height / 15,
                        MediaQuery.of(context).size.width / 7,
                        0),
                    child: Text(UID)),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/profile.png',
                  width: MediaQuery.of(context).size.height / 9,
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Elector\'s Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ':',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Date of Birth',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ":",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$DOB",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ":",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$gender",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
