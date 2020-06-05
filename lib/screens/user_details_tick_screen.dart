import 'dart:async';

import 'package:chat/screens/home_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsTakenScreen extends StatefulWidget {

static const routeName = '/user-details-tick-screen';

  @override
  _UserDetailsTakenScreenState createState() => _UserDetailsTakenScreenState();
}

class _UserDetailsTakenScreenState extends State<UserDetailsTakenScreen> {

@override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, HomeScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Stack(
          children: [FlareActor("assets/animations/Tick1.flr",
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                animation: "Idle"),
                Positioned(
                  width: width,
                  top: height/4,
                  left: width/500,
                  child: Text(
                          'Account Created Successfully',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.josefinSans(
                              color: Colors.orange,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                ),
           ] 
           
           ),
      ),
      
    );
  }
}