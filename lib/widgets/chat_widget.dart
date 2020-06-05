import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatWidget extends StatelessWidget {
  final String userUID;
  final String friendUID;
  final String userName;

  ChatWidget(
      {@required this.userUID,
      @required this.friendUID,
      @required this.userName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(
              'USER/${userUID.trim()}/Friends/${friendUID.trim()}/Messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
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

        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.chat_bubble_outline,
                  size: 50,
                  color: Colors.black26,
                ),
                SizedBox(height: 50),
                Text(
                  'Text \n${userName.trim()} \nto Chat',
                  style: GoogleFonts.breeSerif(
                      fontSize: 30, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final chatDocs = snapshot.data.documents;

        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              DateTime createdAt = chatDocs[index]['createdAt'].toDate();
              final finalCreatedAt =
                  DateFormat.yMMMd().add_jm().format(createdAt);
              if (chatDocs[index]['Sender'] == userUID)
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          alignment: Alignment.centerLeft,
                          color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  chatDocs[index]['Text'],
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  finalCreatedAt,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white70, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        alignment: Alignment.centerLeft,
                        color: Colors.yellowAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                chatDocs[index]['Text'],
                                textAlign: TextAlign.start,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black87, fontSize: 20),
                              ),
                              Text(
                                finalCreatedAt,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black38, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
