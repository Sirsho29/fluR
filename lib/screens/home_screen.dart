import 'package:chat/screens/all_friends.dart';
import 'package:chat/screens/friend_request.dart';
import 'package:chat/screens/friends_chat_screen.dart';
//import 'package:chat/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

  String userUID;

  FirebaseUser loggedInUser;

  String friendUID;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      setState(() {
        userUID = user.uid;
      });
      if (user != null) loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: MyDrawer(userUID: userUID,)),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            'fluR',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'BreeSerif-Regular',
            ),
          ),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
                size: 30,
              ),
              
            ),
            Tab(
              icon: Icon(
                FontAwesomeIcons.userFriends,
                color: Colors.white,
                size: 30,
              ),
              
            ),
            Tab(
              icon: Icon(
                FontAwesomeIcons.userPlus,
                color: Colors.white,
                size: 25,
              ),
              
            ),
          ]),
        ),
        body: TabBarView(children: <Widget>[FriendsChatScreen(), AllFriends(),FriendRequest()],
        dragStartBehavior: DragStartBehavior.start,
        ),
      ),
    );
  }
}
