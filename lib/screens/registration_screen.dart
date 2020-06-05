import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/take_user_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'Registration-screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userEmail;
  String userPassword;

  bool spinnerLoading;
  var authResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _handleSignIn(BuildContext ctx) async {
    try {
      setState(() {
        spinnerLoading = true;
      });
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      if (await _googleSignIn.isSignedIn())
        Navigator.of(context)
            .pushReplacementNamed(TakeUserDetailsScreen.routeName);

      return user;
    } on PlatformException catch (e) {
      var message = 'An error occurred, please check your credentials!';

      if (e.message != null) {
        message = e.message;
      }
      print(e);
      showDialog(
          context: ctx,
          builder: (ctx) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.yellow,
                    width: 2,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Error',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      message.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.breeSerif(
                        color: Colors.redAccent,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  static final FacebookLogin _facebookLogIn = new FacebookLogin();

  Future<FirebaseUser> _fbLogin(BuildContext ctx) async {
    try {
      final FacebookLoginResult result = await _facebookLogIn.logIn(['email']);

      setState(() {
        spinnerLoading = true;
      });

      if (result.status == FacebookLoginStatus.loggedIn) {
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        final AuthCredential fbCredential =
            FacebookAuthProvider.getCredential(accessToken: accessToken.token);
        final FirebaseUser fbUser =
            (await _auth.signInWithCredential(fbCredential)).user;

        if (await _facebookLogIn.isLoggedIn)
          Navigator.of(context)
              .pushReplacementNamed(TakeUserDetailsScreen.routeName);

        return fbUser;
      }
      return null;
    } on PlatformException catch (e) {
      var message = 'An error occurred, please Login Again';

      if (e.message != null) {
        message = e.message;
      }
      print(e);
      showDialog(
          context: ctx,
          builder: (ctx) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.yellow,
                    width: 2,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Error',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      message.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.breeSerif(
                        color: Colors.redAccent,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  void _registerUserWithEmailAndPassword(
    BuildContext ctx,
  ) async {
    setState(() {
      spinnerLoading = true;
    });
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      if (newUser != null)
        Navigator.of(context)
            .pushReplacementNamed(TakeUserDetailsScreen.routeName);
      setState(() {
        spinnerLoading = false;
      });
    } on PlatformException catch (e) {
      var message = 'An error occurred, please check your credentials!';

      if (e.message != null) {
        message = e.message;
      }
      print(e);
      showDialog(
          context: ctx,
          builder: (ctx) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.yellow,
                    width: 2,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Error',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      message.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.breeSerif(
                        color: Colors.redAccent,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            height: height,
            width: double.infinity,
            child: FlareActor("assets/animations/back.flr",
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: "Background Loop"),
          ),
          Positioned(
            height: 100,
            width: width,
            top: height / 11,
            //left: width / 4,
            child: Center(
              child: TypewriterAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: ["fluR"],
                textStyle:
                    GoogleFonts.breeSerif(fontSize: 70.0, color: Colors.white),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart,
                speed: Duration(seconds: 2),
                totalRepeatCount: 1,
              ),
            ),
          ),
          Positioned(
            height: 200,
            width: 200,
            top: height / 4.5,
            left: width / 4.5,
            child: FlareActor("assets/animations/FluChatLogo.flr",
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: "active"),
          ),
          Positioned(
            height: 70,
            width: width,
            top: height / 2,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 8.0, left: 17),
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
                  keyboardType: TextInputType.emailAddress,
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
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Enter Email ID",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  textCapitalization: TextCapitalization.none,
                  style: GoogleFonts.breeSerif(
                    color: Colors.orange,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 70,
            width: width,
            top: height / 1.7,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 8.0, left: 17),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 3,
                color: Colors.white,
                child: PasswordField(
                  onSubmit: (value) {
                    setState(() {
                      userPassword = value;
                    });
                  },
                  color: Colors.black54,
                  hasFloatingPlaceholder: true,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.breeSerif(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  inputStyle: GoogleFonts.breeSerif(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(width: 0, color: Colors.black54)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(width: 0, color: Colors.black54)),
                ),
              ),
            ),
          ),
          Positioned(
              top: height / 1.44,
              left: width / 2.85,
              child: (spinnerLoading == true)
                  ? Container(
                      height: 37.5,
                      width: 100,
                      child: FlareActor("assets/animations/load2.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.scaleDown,
                          animation: "animate"),
                    )
                  : MaterialButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      child: Text(
                        'Register',
                        style: GoogleFonts.breeSerif(
                            color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () {
                        _registerUserWithEmailAndPassword(context);
                      })),
          Positioned(
            top: height / 1.25,
            left: width / 2.7,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.google,
                      size: 30,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      _handleSignIn(context);
                    }),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebookSquare,
                      size: 30,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      _fbLogin(context);
                    })
              ],
            ),
          ),
          Positioned(
              top: height / 1.1,
              left: width / 4.2,
              child: Center(
                  child: FlatButton(
                child: Text(
                  'Already Registered?',
                  style:
                      GoogleFonts.breeSerif(color: Colors.white, fontSize: 20),
                ),
                splashColor: Colors.transparent.withOpacity(0),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              )))
        ]),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return null;
}
