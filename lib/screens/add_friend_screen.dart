import 'package:flutter/material.dart';

class AddFriend extends StatelessWidget {

static const routeName = '/add-friend';

  @override
  Widget build(BuildContext context) {

final routeArg = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
final userUID = routeArg['userUID'];
final friendUID = routeArg['friendUID'];
final userUserName = routeArg['userFullName'];

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      
    );
  }
}