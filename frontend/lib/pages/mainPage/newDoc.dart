import 'dart:ffi';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/mainPage.dart';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';
import './contractConnections.dart';
import 'package:web3dart/web3dart.dart';
import 'package:image_picker/image_picker.dart';

const List<String> documentType = <String>['Aadhaar', 'VoterID'];
const List<String> genderType = <String>['male', 'female'];
final Color favColor = Color(0xFF4C39C3);

class demographicid {
  String name;
  BigInt birthDate;
  String gender;
  String homeAddress;
  BigInt mobileNumber;
  String emailId;
  demographicid(this.name, this.birthDate, this.gender, this.homeAddress,
      this.mobileNumber, this.emailId);
}

class biometricid {
  String fingerprint;
  String irisLeft;
  String irisRight;
  String photo;
  biometricid(this.fingerprint, this.irisLeft, this.irisRight, this.photo);
}

class AddDocument extends StatefulWidget {
  const AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        bid[3] = pickedFile.path;
      });
        
    }
}
  String dropdownValue = documentType.first;
  String gender1 = genderType.first;
  var gender;
  late List<dynamic> did;
  late String dob;
  late String number;
  var bid;
  void initState() {
    super.initState();
    dob = "2004-09-13";
    number = "9958219603";
    did = <dynamic>[
      "Joe",
      BigInt.from(DateTime.parse(dob).millisecondsSinceEpoch),
      gender1,
      "Guindy, Chennai",
      BigInt.parse(number),
      "123@gmail.com"
    ];
    bid = ["fingerprint", "irisleft", "irisright", "photo"];
  }

  final _formKey = GlobalKey<FormState>();

  interaction() async {
    final client = await main();
    final aadhaarcontract = await returnaadhaarcontract();
    final createAadhar = await createAadhaar();
    var adhaarid;

    
    final prefs = await getPref();
    EtherAmount h = EtherAmount.inWei(BigInt.from(67956978238));
    // String source = '44Ff4bE80A6915EE9086';
    // Uint8List bytes = Uint8List(int.parse("44Ff4bE80A6915EE9086"));
    client
        .sendTransaction(
      random,
      chainId: 11155111,
      Transaction.callContract(
        gasPrice: h,
        contract: aadhaarcontract,
        function: createAadhar,
        parameters: [did, bid],
      ),
    )
        .then((res) async {
      print(res);
      client.getTransactionReceipt(res).then((r) {
        print(r);
      });
      print(res.runtimeType);
      adhaarid = res;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainPage()));
    });
    // await prefs.setString('AadhaarId', adhaarid);
  }

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
        title: Text('Add Document'),
        centerTitle: true,
        backgroundColor: favColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Document Type',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: Alignment.center,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.deepPurple),
                      underline: Container(),
                      items: documentType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) => {
                      setState(() {
                        did[0] = value;
                      })
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Enter your Name'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value[2] != '/' ||
                          value[5] != '/' ||
                          value.length < 10) {
                        return 'Please enter valid date';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Date of Birth',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButton<String>(
                      value: gender,
                      alignment: Alignment.center,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.deepPurple),
                      underline: Container(),
                      items: genderType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          gender1 = value!;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) {
                      // This is called when the user selects an item.
                      setState(() {
                        number = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return 'Please enter valid number';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Mobile Number',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) {
                      // This is called when the user selects an item.
                      setState(() {
                        did[3] = value;
                      });
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Address',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: TextFormField(
                    onChanged: (value) {
                      // This is called when the user selects an item.
                      setState(() {
                        did[5] = value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid email';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Email Address',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () => _getFromGallery(),
                    height: 50.0,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    color: favColor,
                    child: Text(
                      'Upload photo here',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () => interaction(),
                    height: 50.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
