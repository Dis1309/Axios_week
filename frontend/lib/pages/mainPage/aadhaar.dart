import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/mainPage/contractConnections.dart';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import 'package:intl/intl.dart';
import 'package:web3dart/web3dart.dart';
import 'package:async/async.dart';

final Color favColor = Color(0xFF4C39C3);

class Aadhaar extends StatefulWidget {
  const Aadhaar({Key? key}) : super(key: key);

  @override
  State<Aadhaar> createState() => _AadhaarState();
}

class _AadhaarState extends State<Aadhaar> {
  
  var details;
  var imageFile;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var data = [];
  void initstate() {
    super.initState();
    getinfo();
    print(1);
  }
//   void main1(file) {
//   File(file).readAsString().then((String contents) {
//     return contents;
//   });
// }

 String name = "";
  String DOB = "";
  String gender = "";
  String add = "";
  String UID = 'ca7f43932fe8d8682cf6c267ed7baca195c8beeb3635a23e712379f1baa05e20';
  String lion = 'assets/lion.png';
  String photo = 'assets/profile.png';
  String email = '';
  getinfo()  {
    return this._memoizer.runOnce(() async {
   final client = await main();
    final aadhaarcontract = await returnaadhaarcontract();
    final getAll = await getAllAadhaar();
    const fingerprint = "fingerprint";
    final prefs = await getPref();
    await dotenv.load(fileName: "assets/.env");
    print(EthereumAddress.fromHex("${dotenv.env['PUBLIC_KEY2']}"));
    EtherAmount h = EtherAmount.inWei(BigInt.from(60000000000));
    // var aadhaarId = await prefs.getString('AadhaarId');
    String source = '44Ff4bE80A6915EE9086';
    // Uint8List bytes = Uint8List(int.parse("44Ff4bE80A6915EE9086"));
    try {
      client
          .call(
          sender: EthereumAddress.fromHex("${dotenv.env['PUBLIC_KEY1']}"),
          contract: aadhaarcontract,
          function: getAll,
          params: [],
          ).then((x){
 print( x);
 setState(() {
   name = x[0][1][0];
   BigInt j = x[0][1][1];
   imageFile = File(x[0][0][3]);
  print(x[0][0][3]);
   print(j);
   int h = j.toInt();
   print((x[0][1][1]).runtimeType);
   DateTime now = DateTime.fromMicrosecondsSinceEpoch(h, isUtc:true)  ;
  //  DOB = DateFormat('dd-MM-yyyy').format(now);
   add = x[0][1][3];
   email = x[0][1][5];
  gender = x[0][1][2];
   print(DOB);
 });
          }).catchError((e) {
            print(e);
          });
         
          // print(x.first.toString())
    } catch (e) {
      print(e);
    }
    });
    
  }

 
  @override
  Widget build(BuildContext context) {
    var heightsize = MediaQuery.of(context).size.height;
    var widthsize = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getinfo(),
      builder: (context,snapshot) {
       if(snapshot.connectionState == ConnectionState.done) {return Scaffold(
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
                            ElevatedButton(
                                onPressed: () => getinfo(),
                                child: Text("Government of India")),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            imageFile == null ? Image.asset(
                              photo,
                              width: 100,
                              height: 150,
                            ) : Image.file(
                              imageFile,
                              width: 100,
                              height: 150,
                            ),
                            Column(
                              children: <Widget>[
                                Text(name),
                                Text('DOB: ${DOB}'),
                                Text(gender),
                                Text(add),
                                Text(email)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("ca7f43932fe8d8682cf6c267ed7baca195c8beeb3635a23e712379f1baa05e20"),
                            )),
                          ),
                        ),
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
      }else {
          // Show loading during the async function finish to process
          return Scaffold(body :Center(child: Container(child:CircularProgressIndicator())) );
        }}
    );
  }
}
