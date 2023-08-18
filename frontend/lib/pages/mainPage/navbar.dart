import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sideBar.dart';
//
// class Navbar extends StatelessWidget {
//   const Navbar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: SideBar(),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: Color(0xFF4C39C3),
//                 ),
//                 margin: EdgeInsets.all(10),
//                 padding: EdgeInsets.symmetric(vertical: 5.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                         onPressed: (){
//                           Scaffold.of(context).openDrawer();
//                         },
//                         icon: Image.asset('assets/menu.png',width: 40,height: 35,)),
//                     Row(
//                       children: <Widget>[
//                         Image.asset('assets/lock.png',width: 40,height: 35,),
//                         Text('Name',
//                           style: TextStyle(
//                             fontSize: 30.0,
//                             color: Colors.white,
//                           ),)
//                       ],
//                     ),
//                     IconButton(onPressed: (){},iconSize: 35,icon: Icon(Icons.account_circle_rounded,color: Colors.white,))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

