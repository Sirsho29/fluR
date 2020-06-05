import 'dart:io';

import 'package:chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TakeUserDetailsScreen extends StatefulWidget {
  static const routeName = '/take-user-details-screen';

  @override
  _TakeUserDetailsScreenState createState() => _TakeUserDetailsScreenState();
}

class _TakeUserDetailsScreenState extends State<TakeUserDetailsScreen> {
  String userFullName;

  String userUserName;

  String userAge;

  String userStatus;

  String userUID;

  String userEmail;

  String userPhone;

  final _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

  String animComplete = '';

  FirebaseUser loggedInUser;

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

  File _pickedImage;

  bool _spinnerLoading = false;

  _pickImageCamera() async {
    final _pickedCameraImageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _pickedImage = _pickedCameraImageFile;
    });
  }

  _pickImageGallery() async {
    final _pickedGalleryImageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _pickedImage = _pickedGalleryImageFile;
    });
  }

  void _startPickingImage(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: ctx,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  dense: true,
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      icon: Icon(
                        Typicons.delete_outline,
                        size: 40,
                        color: Colors.black,
                      )),
                  title: Text(
                    'Choose An Option',
                    style: GoogleFonts.josefinSans(
                        color: Colors.redAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        size: 30,
                        color: Colors.yellow,
                      ),
                      onPressed: _pickImageCamera,
                    ),
                    Text(
                      'Camera',
                      style: GoogleFonts.josefinSans(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.images,
                          size: 30,
                          color: Colors.blue,
                        ),
                        onPressed: _pickImageGallery),
                    Text(
                      'Gallery',
                      style: GoogleFonts.josefinSans(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Typicons.cancel_outline,
                          size: 30,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        }),
                    Text(
                      'None',
                      style: GoogleFonts.josefinSans(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final List<Container> _containers = [
      Container(
        color: Colors.lightBlue[200],
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            FlareActor("assets/animations/cartoon.flr",
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                animation: "Wave"),
            Positioned(
              top: height / 8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hey\nThere!',
                    style: GoogleFonts.josefinSans(
                      color: Colors.green[800],
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height / 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 40),
                  child: Text(
                    'Welcome to\nfluR ...',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.josefinSans(
                        color: Colors.deepPurple,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height / 10,
              left: width / 2.5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Lets Get Started',
                    style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.8),
                  ),
                  Icon(
                    Typicons.arrow_right_outline,
                    size: 35,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.green[200],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //SizedBox(height: MediaQuery.of(context).padding.top,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 40, bottom: 30),
                child: Text(
                  'Please Provide Your Details ...',
                  style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.black54,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Your Name",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.purpleAccent),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.purpleAccent),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.purpleAccent),
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.black54,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Age",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.green[800]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.green[800]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.green[800]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    style: GoogleFonts.breeSerif(
                      color: Colors.green[800],
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.black54,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Username",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.black54),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.black54),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.black54),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    style: GoogleFonts.breeSerif(
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.black54,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Status",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.brown),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.brown),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.brown),
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.yellow,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Email Id",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.yellow),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.yellow),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.yellow),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    style: GoogleFonts.breeSerif(
                      color: Colors.yellow,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10.0, right: 8.0, left: 17),
                child: Card(
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
                    // controller: _textEditingController,
                    cursorColor: Colors.black54,
                    textAlign: TextAlign.center,
                    showCursor: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.breeSerif(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: "Phone Number",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.lightBlue),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Next',
                    style: GoogleFonts.josefinSans(
                        color: Colors.black45,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.8),
                  ),
                  Icon(
                    Typicons.arrow_right_outline,
                    size: 35,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.orange[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).padding.top + (height * 0.01)),
            CircleAvatar(
              radius: width / 4,
              backgroundColor: Colors.white,
              backgroundImage:
                  (_pickedImage != null) ? FileImage(_pickedImage) : null,
              child: (_pickedImage == null)
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(width / 4)),
                      child: Image.asset(
                        'assets/none.jpg',
                      ))
                  : null,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.image,
                color: Colors.red,
                size: 30,
              ),
              title: Text(
                'Add Profile Picture',
                style: GoogleFonts.josefinSans(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.only(left: width / 6),
              onTap: () {
                _startPickingImage(context);
              },
            ),
            SizedBox(height: height * 0.1),
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
                : Container(
                    width: 300,
                    child: MaterialButton(
                        height: 45,
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: Colors.orange,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.josefinSans(
                                color: Colors.orange,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _spinnerLoading = true;
                          });

                          if (userFullName == null ||
                              userAge == null ||
                              userStatus == null ||
                              userUserName == null ||
                              userPhone == null ||
                              userEmail == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Colors.redAccent, width: 2)),
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.sadCry,
                                                color: Colors.lightGreen,
                                                size: 40,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Enter All Details',
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
                          }

                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('user_profile_picture')
                              .child(userUID + '.jpg');
                          await ref.putFile(_pickedImage).onComplete;
                          final imageUrl = await ref.getDownloadURL();

                          await Firestore.instance
                              .collection('USER')
                              .document(userUID)
                              .setData({
                            'Name': userFullName,
                            'Age': userAge,
                            'Status': userStatus,
                            'Username': userUserName,
                            'userUIDfromFirebase': userUID,
                            'email': userEmail,
                            'phone': userPhone,
                            'rated': 0,
                            'profilePicture': (_pickedImage == null)
                                ? 'https://firebasestorage.googleapis.com/v0/b/fluchat-cf0a6.appspot.com/o/user_profile_picture%2Fnone.jpg?alt=media&token=60104164-eab9-4177-874b-7abc917b2c62'
                                : imageUrl,
                          }).whenComplete(() {
                            _spinnerLoading = false;
                          }).whenComplete(() {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  setState(() {
                                    _spinnerLoading = false;
                                  });
                                  return Material(
                                    type: MaterialType.transparency,
                                    child: Center(
                                        child: GestureDetector(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            width: 150.0,
                                            height: 150.0,
                                            child: FlareActor(
                                                "assets/animations/load5.flr",
                                                alignment: Alignment.center,
                                                fit: BoxFit.scaleDown,
                                                animation: "Success"),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                HomeScreen.routeName);
                                      },
                                    )),
                                  );
                                });
                          });
                        }),
                  ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(child: _containers[index]);
        },
        itemCount: _containers.length,
        loop: false,
        curve: Curves.bounceInOut,
        autoplay: false,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.blue,
            color: Colors.purple,
            size: 10,
            activeSize: 15,
          ),
        ),
        itemHeight: height,
        itemWidth: width,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
