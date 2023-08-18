import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/account.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);


  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFF4C39C3),
            ),
            child:ListTile(
              leading: Icon(Icons.account_circle_rounded,
              size: 30.0,
              color: Colors.white,),
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('John',style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle,size: 30.0,),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Add Document',
              style: TextStyle(
                fontSize: 20.0,
              ),),
            onTap: (){
              setState(() {

              });
            },
          ),
          ListTile(
            leading: Icon(Icons.home,size: 30.0,),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Home',
            style: TextStyle(
              fontSize: 20.0,
            ),),
            onTap: (){

            },
          ),
          ListTile(
            leading: Icon(Icons.settings,size: 30.0,),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Settings',
              style: TextStyle(
                fontSize: 20.0,
              ),),
          ),
        ],
      ),
    );
  }
}
