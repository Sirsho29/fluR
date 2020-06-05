import 'dart:async';

import 'package:chat/screens/registration_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RegistrationScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.lightBlueAccent],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlareActor("assets/animations/Splash1.flr",
            alignment: Alignment.center, fit: BoxFit.contain, animation: "Anim"),
      ),
    );
  }
}
