import 'package:flutter/material.dart';
import 'package:frontend/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Login',
        style: TextStyle(
          fontSize: 25.0,
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/32,),
              Container(
                alignment: Alignment.center,
                child: Text('Log in with one of the following',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),)),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black,width: 2.0)
                    ),
                    child: IconButton(
                      iconSize: 40.0,
                      onPressed: (){},
                      icon: Image.asset('assets/google.png'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,width: 2.0)
                    ),
                    child: IconButton(
                      iconSize: 40.0,
                      onPressed: (){},
                      icon: Image.asset('assets/github.png'),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/32,),
              Text('Or',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.deepPurpleAccent
              ),),
              SizedBox(height: 10.0,),
              Text('Login using email and password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your email',
                        ),
                      ),SizedBox(height: 10.0,),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your password',
                        ),
                      ),SizedBox(height: 20.0,),
                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: (){},
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: Colors.blue.shade900,
                  child: Text('Login',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),),),
              ),Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already registered',style: TextStyle(fontSize: 16.0),),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>Register()));
                      },
                      child: Text('Click here',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/70,),
              Text('Or',
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.deepPurpleAccent
                ),),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Text('Login using fingerprint',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: (){},
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: Colors.blue.shade900,
                  child: Text('Click Here',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}