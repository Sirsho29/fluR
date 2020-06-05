import 'package:chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AllUsersScreen extends StatefulWidget {
  static const routeName = '/all-users-screen';

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  String searchKeyWord;

  String userUID;

  final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

  FirebaseUser loggedInUser;

  String friendUID;

  // String searchKeyWord = '';

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

    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // final userUID = routeArgs['userUID'];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              }),
          backgroundColor: Colors.orangeAccent,
          actionsIconTheme: IconThemeData(),
          title: const Text(
            'Search A User',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'BreeSerif-Regular',
            ),
          ),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orangeAccent,
            title: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 0.07 * MediaQuery.of(context).size.height,
                child: TextField(
                  // controller: _textEditingController,
                  cursorColor: Colors.white70,
                  // autofocus: true,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorRadius: Radius.circular(15),
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.quicksand(color: Colors.white),
                    labelText: "Search Friends",
                    fillColor: Colors.grey[900],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                    ),
                  ),
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 17,
                    //fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchKeyWord = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('USER').snapshots(),
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

              List<String> userFriends = [];
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('USER/$userUID/Friends')
                      .snapshots(),
                  builder: (context, friendSnapshots) {
                    if (friendSnapshots.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final friendsData = friendSnapshots.data.documents;
                    for (var eachFriend in friendsData) {
                      final String friendUID = eachFriend.data['friendUID'];
                      userFriends.add(friendUID);
                    }
                  });

              final userData = snapshot.data.documents;
              final List<Column> finalAllUsersData = [];
              for (var eachUser in userData) {
                final userUsername = eachUser.data['Username'];
                final userDp = eachUser.data['profilePicture'];
                final userStatus = eachUser.data['Status'];
                final userUIDfromFirebase =
                    eachUser.data['userUIDfromFirebase'];

                final Widget eachFriendTile =
                    Column(mainAxisSize: MainAxisSize.min, children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 8, left: 8),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userDp),
                    ),
                    title: GestureDetector(
                      child: Text(
                        userUsername,
                        style: GoogleFonts.breeSerif(fontSize: 20),
                      ),
                      onTap: (){
                        
                      },
                    ),
                    subtitle: Text(userStatus,
                        style: GoogleFonts.openSans(fontSize: 15)),
                    trailing: (!userFriends.contains(userUIDfromFirebase))
                        ? IconButton(
                            icon: Icon(
                              FontAwesomeIcons.userPlus,
                              color: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              Firestore.instance
                                  .collection('USER/$userUID/Friends')
                                  .document(userUIDfromFirebase)
                                  .setData({
                                'friendUID': userUIDfromFirebase,
                                'isChatting': false,
                                'friendRequest': false,
                              });
                              Firestore.instance
                                  .collection(
                                      'USER/$userUIDfromFirebase/Friends')
                                  .document(userUID)
                                  .setData({
                                'friendUID': userUID,
                                'isChatting': false,
                                'friendRequest': true,
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
                                                'Friend Request Sent',
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
                            })
                        : Icon(Icons.beenhere, color: Colors.lightGreen),
                  ),
                  Divider(
                    color: Colors.black26,
                    thickness: 0,
                    endIndent: width / 20,
                    indent: width / 20,
                  ),
                ]);

                (userUID != userUIDfromFirebase)
                    ? finalAllUsersData.add(eachFriendTile)
                    : null;

                print('Final USer Length = ${finalAllUsersData.length}');
                print('Final USer Length = ${userFriends.length}');
              }
              return ListView.builder(
                  itemCount: finalAllUsersData.length,
                  itemBuilder: (context, index) {
                    return finalAllUsersData[index];
                  });
            }));
  }
}
