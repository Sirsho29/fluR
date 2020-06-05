import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Image.asset(
          'assets/icon.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
