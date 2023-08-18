import 'package:flutter/material.dart';
import 'navbar.dart';

// Widget AllDocuments =  Container(
//   child: Text('hello world'),
// );


class AllDocuments extends StatefulWidget {
  const AllDocuments({Key? key}) : super(key: key);

  @override
  State<AllDocuments> createState() => _AllDocumentsState();
}

class _AllDocumentsState extends State<AllDocuments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('all documents')
    );
  }
}
