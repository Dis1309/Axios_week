import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:frontend/pages/mainPage/newDoc.dart';
import 'package:frontend/pages/mainPage/settings.dart';
import 'package:frontend/pages/mainPage/AllDocument.dart';
import 'package:frontend/pages/mainPage/sideBar.dart';
// import 'navbar.dart';
import 'account.dart';
import 'contractConnections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  final List<Widget> screen = [
    AllDocuments(),
    Settings(),
  ];

  final List<Widget> _widgetOptions = [
    AllDocuments(),
    Settings(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = AllDocuments();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Color favColor = Color(0xFF4C39C3);
  var Name;
  void initState() {
    super.initState();
    Name = "";
    getInfo();
    print(Name);
  }

  getInfo() async {
    final prefs = await getPref();
    var name = await prefs.getString('Name');
    print(name);
    setState(() {
      Name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: favColor,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle_rounded,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  // titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'John',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_circle,
                  size: 30.0,
                ),
                // titleAlignment: ListTileTitleAlignment.center,
                selected: currentTab == 2,
                selectedColor: favColor,
                title: Text(
                  'Add Document',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentTab = 2;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDocument()));
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.home, size: 30.0),
                // titleAlignment: ListTileTitleAlignment.center,
                selected: currentTab == 0,
                selectedColor: favColor,
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentTab = 0;
                    currentScreen = AllDocuments();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, size: 30.0),
                // titleAlignment: ListTileTitleAlignment.center,
                selected: currentTab == 1,
                selectedColor: favColor,
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentTab = 1;
                    currentScreen = Settings();
                    Navigator.pop(context);
                  });
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30.0,
                ),
                selected: true,
                selectedColor: Colors.grey.shade700,
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: RichText(
                      selectionColor: Colors.black,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Made with ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                              )),
                          WidgetSpan(
                              child: Image.asset(
                            'assets/love.png',
                            width: 25.0,
                          )),
                          TextSpan(
                              text: ' By',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: RichText(
                    selectionColor: Colors.black,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Project',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFF4C39C3),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState?.openDrawer(),
                          icon: Image.asset(
                            'assets/menu.png',
                            width: 40,
                            height: 35,
                          )),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/lock.png',
                            width: 40,
                            height: 35,
                          ),
                          Text(
                            Name,
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                          iconSize: 35,
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: currentScreen,
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 2;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddDocument()));
          });
        },
        backgroundColor: Color(0xFF4C39C3),
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = AllDocuments();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Color(0xFF4C39C3) : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Color(0xFF4C39C3)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Settings();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color:
                              currentTab == 1 ? Color(0xFF4C39C3) : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Color(0xFF4C39C3)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
