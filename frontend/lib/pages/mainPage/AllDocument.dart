import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/aadhaar.dart';
import 'package:frontend/pages/mainPage/voterId.dart';
import 'package:frontend/services/details.dart';
import 'package:frontend/services/File.dart';
// Widget AllDocuments =  Container(
//   child: Text('hello world'),
// );


class AllDocuments extends StatefulWidget {
  const AllDocuments({Key? key}) : super(key: key);

  @override
  State<AllDocuments> createState() => _AllDocumentsState();
}

class _AllDocumentsState extends State<AllDocuments> {

  List<File> files = [
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
    File(documentType: "Aadhaar",documentName: "Aadhaar"),
    File(documentType: "VoterId",documentName: "VoterId"),
  ];

  final Color favColor = Color(0xFF4C39C3);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('All Documents',
        style: TextStyle(
          fontSize: 25.0,
        ),),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 20.0),
             child: Divider(thickness: 2.0,)),
         Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: double.infinity,
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(favColor),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: (){
                          if(files[index].documentName=='Aadhaar'){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Aadhaar()));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VoterId()));
                          }
                        },
                        icon: Icon(Icons.file_copy), 
                        label: Text(files[index].documentName)));
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        SizedBox(height: 20,)
      ],
    );
  }
}
