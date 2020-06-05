import 'package:chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class UserProfilePage extends StatelessWidget {
  static const routeName = '/user-profile-page';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final userUID = routeArgs['userUID'];

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 50,
                          blurRadius: 30)
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    ),
                    color: Colors.white,
                  ),
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('USER')
                          .document(userUID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 150.0,
                              height: 150.0,
                              child: FlareActor(
                                  "assets/animations/loading1.flr",
                                  alignment: Alignment.center,
                                  fit: BoxFit.scaleDown,
                                  animation: "Untitled"),
                            ),
                          );
                        }

                        return Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.yellow,
                                  backgroundImage: NetworkImage(
                                      snapshot.data['profilePicture'])),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                snapshot.data['Username'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.black87, fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                snapshot.data['Name'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.black54, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                snapshot.data['Status'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.black87, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                'Age : ' + snapshot.data['Age'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.black45, fontSize: 16),
                              ),
                            ),
                            Divider(
                              color: Colors.black54,
                              indent: 100,
                              endIndent: 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13.0, top: 5, bottom: 5),
                                  child: Text(
                                    'Email ID',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black45,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 13.0, top: 5, bottom: 5),
                                  child: Text(
                                    snapshot.data['email'].toString(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black45, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 13.0, top: 5, bottom: 5),
                                  child: Text(
                                    'Phone',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black45,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 13.0, top: 5, bottom: 5),
                                  child: Text(
                                    snapshot.data['phone'].toString(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black45, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black54,
                              indent: 100,
                              endIndent: 100,
                            ),
                            MaterialButton(
                                color: Colors.black12,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Change Details',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                                elevation: 6,
                                onPressed: () {

                                }),
                          ],
                        );
                      })),
            ),
            SizedBox(height: 30),
            IconButton(
                icon: Icon(
                  Typicons.arrow_left_outline,
                  size: 40,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                })
          ],
        ),
      ),
    );
  }
}
