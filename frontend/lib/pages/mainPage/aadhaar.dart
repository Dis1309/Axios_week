import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/mainPage/contractConnections.dart';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import 'package:web3dart/web3dart.dart';

final Color favColor = Color(0xFF4C39C3);

class Aadhaar extends StatefulWidget {
  const Aadhaar({Key? key}) : super(key: key);

  @override
  State<Aadhaar> createState() => _AadhaarState();
}

class _AadhaarState extends State<Aadhaar> {
  var details;
  void initstate() {
    super.initState();
    getinfo();
    print(1);
  }

  getinfo() async {
    final client = await main();
    final aadhaarcontract = await returnaadhaarcontract();
    final getAll = await getAllAadhaar();
    const fingerprint = "fingerprint";
    final prefs = await getPref();
    EtherAmount h = EtherAmount.inWei(BigInt.from(60000000000));
    // var aadhaarId = await prefs.getString('AadhaarId');
    String source =
        '0000000000000000000000000000000000000000000000000000000000000013';
    Uint8List bytes = source.toUint8List();
    try {
      client
          .sendTransaction(
        random,
        chainId: 11155111,
        Transaction.callContract(
          gasPrice: h,
          contract: aadhaarcontract,
          function: getAll,
          parameters: [fingerprint.toString(), bytes],
        ),
      )
          .then((res) {
        print(res);
        print(res.runtimeType);
        details = res;
      });
    } catch (e) {
      print(e);
    }
  }

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
                        Image.asset(
                          photo,
                          height: 200,
                        ),
                        Column(
                          children: <Widget>[
                            Text(name),
                            Text('DOB: ${DOB}'),
                            Text(gender),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(UID),
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
  }
}
