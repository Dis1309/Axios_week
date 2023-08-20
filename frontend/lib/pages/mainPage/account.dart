import 'package:flutter/material.dart';
import 'package:frontend/pages/homePage.dart';
import 'package:frontend/pages/mainPage/mainPage.dart';

final Color favColor = Color(0xFF4C39C3);

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Fetched data
  String name = "Sridhar Suthapalli";
  String email = "sridharsutapalli@gmail.com";
  DateTime birthDate = DateTime.now();
  String gender = 'male';
  String Address = "Home";
  double phoneNum = 9963194768;

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
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        backgroundColor: favColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width / 6,
                  child: Image.asset(
                    'assets/google.png',
                  ),
                ),
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('$email',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '+91 ${phoneNum.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Expanded(child: TextButton.icon(onPressed: (){}, icon: Icon(Icons.logout), label: Text('Logout')))
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                width: double.infinity,
                child: TextButton.icon(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 10.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(favColor),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 22.0))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  IntroductionApp()),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.logout),
                    label: Text('Logout')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
