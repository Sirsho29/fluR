import 'package:chat/screens/all_users_screen.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/settings_screens.dart/about.dart';
import 'package:chat/settings_screens.dart/rating.dart';
import 'package:chat/settings_screens.dart/settings.dart';
import 'package:chat/settings_screens.dart/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class MyDrawer extends StatefulWidget {
  final String userUID;

  MyDrawer({this.userUID});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
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

    return Drawer(
      elevation: 50,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.tealAccent,
                height: MediaQuery.of(context).padding.top),
            StreamBuilder(
                stream: Firestore.instance
                    .collection('USER')
                    .document(widget.userUID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 150.0,
                        height: 150.0,
                        child: FlareActor("assets/animations/loading1.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            animation: "Untitled"),
                      ),
                    );
                  }

                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.tealAccent,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      snapshot.data['profilePicture'])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/fluchat-cf0a6.appspot.com/o/user_profile_picture%2Ficon.png?alt=media&token=75991835-5fa7-45a7-9a49-4efd65746376')),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              snapshot.data['Username'],
                              style: GoogleFonts.montserrat(
                                  color: Colors.black87, fontSize: 30),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '(' + snapshot.data['Name'] + ')',
                              style: GoogleFonts.montserrat(
                                  color: Colors.black45, fontSize: 20),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 200,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 30),
                              child: Text(
                                snapshot.data['Status'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(height: height * 0.01),
            ListTile(
              title: Text(
                'Home',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(Icons.home, size: 30),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Profile',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(FontAwesomeIcons.userCircle, size: 30),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(UserProfilePage.routeName,arguments: {
                  'userUID':widget.userUID,
                });
              },
            ),
            ListTile(
              title: Text(
                'Find Friends',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(Icons.search, size: 30),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(AllUsersScreen.routeName);
              },
            ),
            
            ListTile(
              title: Text(
                'Settings',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(Icons.settings, size: 30),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(Settings.routeName,arguments: {
                  'userUID':widget.userUID,
                });
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(FontAwesomeIcons.signOutAlt, size: 28),
              onTap: (){
                _auth.signOut().whenComplete((){
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                });
              },
            ),
            Divider(
              color: Colors.black26,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              title: Text(
                'About US',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(FontAwesomeIcons.github, size: 30),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(About.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Rate Us',
                style:
                    GoogleFonts.montserrat(color: Colors.black54, fontSize: 22),
              ),
              trailing: Icon(FontAwesomeIcons.star, size: 25),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(Rating.routeName,arguments: {
                  'userUID':widget.userUID,
                });
              },
            ),
            IconButton(
                icon: Icon(
                  Typicons.delete_outline,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
