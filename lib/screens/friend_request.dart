import 'package:chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendRequest extends StatefulWidget {
  static const routeName = 'friends-request';

  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  String userUID;

  final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

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

    Stream<QuerySnapshot> stream = Firestore.instance
        .collection('USER')
        .document(userUID)
        .collection('Friends')
        .snapshots();

    return Scaffold(
      body: new StreamBuilder(
          stream: stream,
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
            final List<Widget> finalFriendsData = [];
            for (var eachFriend in friendsData) {
              final friendRequest = eachFriend.data['friendRequest'];
              final friendUID = eachFriend.data['friendUID'];

              final eachFriendTile =
                  Column(mainAxisSize: MainAxisSize.min, children: [
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('USER')
                        .document(friendUID)
                        .snapshots(),
                    builder: (context, tempSnapshot) {
                      if (tempSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListTile(
                        contentPadding:
                            EdgeInsets.only(top: 8, left: 8, right: 3),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(tempSnapshot.data['profilePicture']),
                        ),
                        title: Text(
                          tempSnapshot.data['Username'],
                          style: GoogleFonts.breeSerif(fontSize: 20),
                        ),
                        subtitle: Text(tempSnapshot.data['Status'],
                            style: GoogleFonts.openSans(fontSize: 15)),
                        trailing: MaterialButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.redAccent,
                            child: Text(
                              'Accept',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            onPressed: () async {
                              Firestore.instance
                                  .collection('USER/$userUID/Friends')
                                  .document(friendUID)
                                  .updateData({
                                'friendRequest': false,
                              }).whenComplete(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Colors.white,
                                        elevation: 5,
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: Stack(children: [
                                            FlareActor(
                                                "assets/animations/Tick1.flr",
                                                alignment: Alignment.center,
                                                fit: BoxFit.fitWidth,
                                                animation: "Idle"),
                                            Positioned(
                                              //width: width,
                                              top: height / 25,
                                              left: width / 8,
                                              child: Text(
                                                'You Got a New Friend',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.josefinSans(
                                                    color: Colors.orange,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      );
                                    });
                              });
                            }),
                      );
                    }),
                Divider(
                  color: Colors.black26,
                  thickness: 0,
                  endIndent: width / 20,
                  indent: width / 20,
                ),
              ]);
              (friendRequest == true)
                  ? finalFriendsData.add(eachFriendTile)
                  : null;
            }

            if (finalFriendsData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.smile,
                      size: 50,
                      color: Colors.black26,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'You Dont\' Have Any Friend Requests',
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
