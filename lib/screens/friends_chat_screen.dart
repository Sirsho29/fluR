import 'package:chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsChatScreen extends StatefulWidget {
  static const routeName = 'friends-screen';

  @override
  _FriendsChatScreenState createState() => _FriendsChatScreenState();
}

class _FriendsChatScreenState extends State<FriendsChatScreen> {
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

              final isChatting = eachFriend.data['isChatting'];
              final friendUID = eachFriend.data['friendUID'];

              final eachFriendTile =
                  Column(mainAxisSize: MainAxisSize.min, children: [
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('USER')
                        .document(friendUID)
                        .snapshots(),
                    builder: (context, tempSnapshot) {
                      if(tempSnapshot.connectionState == ConnectionState.waiting){
                        return Center(child:CircularProgressIndicator());
                      }
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
                                'userDP':tempSnapshot.data['profilePicture'],
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
              if (isChatting == true) finalFriendsData.add(eachFriendTile);
            }

            if (finalFriendsData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      size: 50,
                      color: Colors.black26,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'You Dont Have Any Chats\nText Someone :)',
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
