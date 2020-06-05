import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewMessage extends StatefulWidget {
  final String userUID;
  final String friendUID;

  NewMessage({
    @required this.userUID,
    @required this.friendUID,
  });

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();

  var _enteredMessage = '';

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    await Firestore.instance
        .collection(
            'USER/${widget.userUID.trim()}/Friends/${widget.friendUID.trim()}/Messages')
        .add({
      'Text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'Sender': widget.userUID,
    });

    await Firestore.instance
        .collection(
            'USER/${widget.userUID.trim()}/Friends').document(widget.friendUID.trim()).updateData({
              'isChatting' : true
            }); 

    await Firestore.instance
        .collection(
            'USER/${widget.friendUID.trim()}/Friends/${widget.userUID.trim()}/Messages')
        .add({
      'Text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'Sender': widget.userUID
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
                labelStyle: GoogleFonts.montserrat(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.orange),
                  borderRadius: BorderRadius.circular(50),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.orange),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.orange),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.montserrat(
                color: Colors.brown,
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Colors.black38,
            icon: Icon(
              Icons.send,
              size: 30,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
