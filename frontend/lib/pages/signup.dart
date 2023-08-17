import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Sign Up'),
        elevation: 0.0,
        centerTitle: true,
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
              Text('Register using email and password',
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
                          labelText: 'Enter your name',
                        ),
                      ),SizedBox(height: 10.0,),
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
                  child: Text('Register',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),),
              ),Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already have an account?',style: TextStyle(fontSize: 16.0),),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Login()));
                      },
                      child: Text('Click here',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}