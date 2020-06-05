import 'package:chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String userFullName;

  String userUserName;

  String userAge;

  String userStatus;

  String userEmail;

  String userPhone;

  var _spinnerLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final userUID = routeArgs['userUID'];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'BreeSerif-Regular',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }),
        backgroundColor: Colors.orangeAccent,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('USER')
              .document(userUID)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white70,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Your Name',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.purpleAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userFullName = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['Name'],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.purpleAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.purpleAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.purpleAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.purpleAccent,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Age',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.orangeAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userAge = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['Age'],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.orangeAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.orangeAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.orangeAccent),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.orangeAccent,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Username',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.brown,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userUserName = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['Username'],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0, color: Colors.brown),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0, color: Colors.brown),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0, color: Colors.brown),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.brown,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Status',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.lightGreen,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userStatus = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['Status'],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightGreen),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightGreen),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightGreen),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.lightGreen,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Email ID',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.yellow[900],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userEmail = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['email'],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.yellow[900]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.yellow[900]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.yellow[900]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.yellow[900],
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Phone Number',
                                style: GoogleFonts.breeSerif(
                                  color: Colors.lightBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userPhone = value;
                                });
                              },
                              cursorColor: Colors.black54,
                              textAlign: TextAlign.left,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hintStyle: GoogleFonts.breeSerif(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: snapshot.data['phone'].toString(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.breeSerif(
                                color: Colors.lightBlue,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (_spinnerLoading == true)
                        ? Center(
                            child: Container(
                              height: 37.5,
                              width: 100,
                              child: FlareActor("assets/animations/load2.flr",
                                  alignment: Alignment.center,
                                  fit: BoxFit.scaleDown,
                                  animation: "animate"),
                            ),
                          )
                        : MaterialButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.redAccent,
                            child: Text(
                              'Save',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                _spinnerLoading = true;
                              });
                              Firestore.instance
                                  .collection('USER')
                                  .document(userUID)
                                  .updateData({
                                'Name': userFullName,
                                'Age': userAge,
                                'Status': userStatus,
                                'Username': userUserName,
                                'userUIDfromFirebase': userUID,
                                'email': userEmail,
                                'phone': userPhone,
                              }).whenComplete(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      setState(() {
                                        _spinnerLoading = false;
                                      });
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
                                                'Data Updated Successfully',
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
                  ],
                ),
              ),
            );
          }),
    );
  }
}
