import 'package:chat/screens/friend_detail_screen_if_friend.dart';
import 'package:chat/widgets/chat_widget.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'chat-screen';

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final userUID = routeArg['userUID'];
    final friendUID = routeArg['friendUID'];
    final userUserName = routeArg['userName'];
    final userDP = routeArg['userDP'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(FriendDetailScreenIfFriend.routeName, arguments: {
              'friendUID': friendUID,
              'userUID':userUID,
            });
          },
          child: Text(
            userUserName,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(userDP),
            ),
          ),
        ],
      ),
      body: Container(
          color: Colors.yellow[100],
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ChatWidget(
                userUID: userUID,
                friendUID: friendUID,
                userName: userUserName,
              )),
              NewMessage(
                userUID: userUID,
                friendUID: friendUID,
              ),
            ],
          )),
    );
  }
}
