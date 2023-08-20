import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/mainPage.dart';

const List<String> documentType = <String>['Aadhaar', 'VoterID'];
const List<String> genderType = <String>['male','female'];
final Color favColor = Color(0xFF4C39C3);

class AddDocument extends StatefulWidget {
  const AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {

  String dropdownValue = documentType.first;
  String gender = genderType.first;

  final _formKey = GlobalKey<FormState>();

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
        title: Text('Add Document'),
        centerTitle: true,
        backgroundColor: favColor,
      ),
      body:SafeArea(
        child:SingleChildScrollView(
        child: Form(
          key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Document Type',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
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
                        fontSize: 18,
                          color: Colors.deepPurple),
                      underline: Container(),
                      items: documentType.map<DropdownMenuItem<String>>((String value) {
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
                      },),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Full Name',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(value==null||value.isEmpty){
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
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Date of Birth',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    validator: (value){
                      if(value==null||value.isEmpty||value[2]!='/'||value[5]!='/'||value.length<10){
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
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Gender',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
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
                          fontSize: 18,
                          color: Colors.deepPurple),
                      underline: Container(),
                      items: genderType.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          gender = value!;
                        });
                      },),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Mobile Number',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value==null||value.isEmpty||value.length<10){
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
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Address',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.streetAddress,
                    validator: (value){
                      if(value==null||value.isEmpty){
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
                      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      child: Text('Email Address',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value==null||value.isEmpty){
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
                  margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {

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
              ],
            ),
          ),
      ),
      ),
    );
  }
}