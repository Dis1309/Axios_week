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
  
  late final LocalAuthentication auth;
  bool _supportState = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    print(auth);
    // auth.getAvailableBiometrics().then((res){
    //    print(res);
    // });
    auth.isDeviceSupported().then((bool isSupported) => setState((){
      _supportState = isSupported;
    }));
  }
  
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/5,),
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
                  onPressed:()=> _authenticate(context)
                  ,
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
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _authenticate(BuildContext context) async{
    final scaffold = ScaffoldMessenger.of(context);
      try{
        bool authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to login',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          )
        );
        if(authenticated){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MainPage()),
                  (Route<dynamic> route) => false);
        }else{
          scaffold.showSnackBar(SnackBar(content: Text('Error loggin in'),action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),));
        }
      }on PlatformException catch(e){
          scaffold.showSnackBar(SnackBar(content: Text('Try using PIN'),action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),));
      }
}
}