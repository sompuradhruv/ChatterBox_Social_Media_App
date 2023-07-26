
import 'package:chatapp_firebase/pages/group_feature/group_page_screen.dart';
import 'package:chatapp_firebase/pages/posts_feature/posts.dart';
import 'package:chatapp_firebase/pages/profile_feature/pro.dart';
import 'package:chatapp_firebase/pages/events_feature/pro_main.dart';
import 'package:chatapp_firebase/pages/events_feature/product_list.dart';
import 'package:chatapp_firebase/pages/video_call_feature/vid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/auth_helper.dart';
import '../service/group_service.dart';
import 'chat_feature/chat_screen.dart';

class bot extends StatefulWidget {
  const bot({super.key});

  @override
  State<bot> createState() => _botState();
}

class _botState extends State<bot> {

  static String userName = "";
  static String email = "";
  Stream? groups;

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  static List<Widget> _pages = <Widget>[
    HomePage(),
    chat(),
    posts(),
    test(),
    pro_main()
  ];
  int _selectedIndex = 0; //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Groups',
              backgroundColor: Color(0xFFf6a806)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chats',
              backgroundColor: Color(0xFFf6a806)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create Posts',
            backgroundColor: Color(0xFFf6a806),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video Chat',
            backgroundColor: Color(0xFFf6a806),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Events',
            backgroundColor: Color(0xFFf6a806),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
