import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/mainPage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:text_divider/text_divider.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({Key? key}) : super(key: key);

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {

  // final LocalAuthentication _localAuthentication =  LocalAuthentication();
  // bool _canCheckBiometric = false;
  // String authorizedOrNot = "Not Authorized";
  // // List<BiometricType> _availableBiometricTypes = List<BiometricType>();
  //
  //  _authorizedNow()async{
  //   bool isAuthorized = false;
  //   try{
  //     isAuthorized = await _localAuthentication.authenticate(localizedReason: 'Please authenticate',
  //      options: AuthenticationOptions(useErrorDialogs: true,stickyAuth: true));
  //   }on PlatformException catch (e){
  //     print(e);
  //   }
  //   if(!mounted){
  //     return;
  //   }
  //
  //   if(isAuthorized){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
  //   }
  //
  // }
  //
  //  _checkBiometric() async{
  //   bool canCheckBiometric = false;
  //   try{
  //     canCheckBiometric = await _localAuthentication.canCheckBiometrics;
  //   }on PlatformException catch (e){
  //     print(e);
  //   }
  //
  //   if(!mounted) return;
  //
  //   if(canCheckBiometric){
  //     _authorizedNow();
  //   }
  // }

  final Color favColor = Color(0xFF4C39C3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Authentication'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/6,),
              Text('Login with Fingerprint/FaceId',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20.0,),
              Image.asset('assets/fingerprint.png',
              width: 50.0,),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/16),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                  },
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: favColor,
                  child: Text(
                    'Login with Fingerprint/FaceId',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),SizedBox(height: 10.0,),
                TextDivider(text: Text('OR',
                style: TextStyle(
                    fontSize: 18.0,
                ),),thickness: 2.0,),
              SizedBox(height: 10.0,),
              Text('Login with PIN',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 15.0,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/16,),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),SizedBox(height: 15.0,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/16),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FingerPrint()));
                  },
                  height: 60.0,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  color: favColor,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0,)
            ],
          ),
        ),
      ),
    );
  }
}
