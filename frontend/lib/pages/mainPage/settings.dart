import 'package:flutter/material.dart';
import 'package:frontend/pages/mainPage/account.dart';
// import 'navbar.dart';
// Widget Settings = Container(
//         child: Column(
//           children: [
//             Text('Settings')
//           ],
//         ),
// );

final Color favColor = Color(0xFF4C39C3);

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 23.0,
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Divider(
              thickness: 2.0,
            )),
        Container(
          decoration: BoxDecoration(
              color: favColor, borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              icon: Icon(Icons.account_circle),
              label: Text(
                'Profile',
                style: TextStyle(fontSize: 20.0),
              )),
        )
      ],
    );
  }
}
