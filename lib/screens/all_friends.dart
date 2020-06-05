import 'package:chat/screens/all_users_screen.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AllFriends extends StatefulWidget {
  static const routeName = '/all-friends-screen';

  @override
  _AllFriendsState createState() => _AllFriendsState();
}

class _AllFriendsState extends State<AllFriends> {
  String userUID;

  final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          child: Icon(
            FontAwesomeIcons.userPlus,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(AllUsersScreen.routeName, arguments: {
              'userUID': userUID,
            });
          }),
      body: new StreamBuilder(
          stream: Firestore.instance
              .collection('USER')
              .document(userUID)
              .collection('Friends')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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

            final friendsData = snapshot.data.documents;
            final List<Column> finalFriendsData = [];
            for (var eachFriend in friendsData) {
              final friendUID = eachFriend.data['friendUID'];

              final Widget eachFriendTile =
                  Column(mainAxisSize: MainAxisSize.min, children: [
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('USER')
                        .document(friendUID)
                        .snapshots(),
                    builder: (context, tempSnapshot) {
                      return ListTile(
                          contentPadding: EdgeInsets.only(top: 8, left: 8),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                tempSnapshot.data['profilePicture']),
                          ),
                          title: Text(
                            tempSnapshot.data['Username'],
                            style: GoogleFonts.breeSerif(fontSize: 20),
                          ),
                          subtitle: Text(tempSnapshot.data['Status'],
                              style: GoogleFonts.openSans(fontSize: 15)),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ChatScreen.routeName,
                              arguments: {
                                'userUID': userUID,
                                'friendUID': friendUID,
                                'userName': tempSnapshot.data['Username'],
                                'userDP': tempSnapshot.data['profilePicture'],
                              },
                            );
                          });
                    }),
                Divider(
                  color: Colors.black26,
                  thickness: 0,
                  endIndent: width / 20,
                  indent: width / 20,
                ),
              ]);
              (eachFriend.data['friendRequest'] == false)
                  ? finalFriendsData.add(eachFriendTile)
                  : null;
            }

            if (finalFriendsData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.plusSquare,
                      size: 50,
                      color: Colors.black26,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Try Adding New Friends',
                      style: GoogleFonts.breeSerif(
                          fontSize: 30, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
                itemCount: finalFriendsData.length,
                itemBuilder: (context, index) {
                  return finalFriendsData[index];
                });
          }),
    );
  }
}
