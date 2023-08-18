import 'package:flutter/material.dart';
import 'navbar.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Text('New document')
          ],
        ),
      );
  }
}
