import 'package:chat/screens/add_friend_screen.dart';
import 'package:chat/screens/all_friends.dart';
import 'package:chat/screens/all_users_screen.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/friend_detail_screen_if_friend.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/preview.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/splash.dart';
import 'package:chat/screens/take_user_details_screen.dart';
import 'package:chat/screens/user_details_tick_screen.dart';
import 'package:chat/settings_screens.dart/about.dart';
import 'package:chat/settings_screens.dart/rating.dart';
import 'package:chat/settings_screens.dart/settings.dart';
import 'package:chat/settings_screens.dart/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Preview();
            }
            if (userSnapshot.hasData) {
              return HomeScreen();
            }
            return Splash();
          }),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        TakeUserDetailsScreen.routeName: (ctx) => TakeUserDetailsScreen(),
        UserDetailsTakenScreen.routeName: (ctx) => UserDetailsTakenScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        AllFriends.routeName: (ctx) => AllFriends(),
        AllUsersScreen.routeName: (ctx) => AllUsersScreen(),
        AddFriend.routeName: (ctx) => AddFriend(),
        FriendDetailScreenIfFriend.routeName: (ctx) =>
            FriendDetailScreenIfFriend(),
        UserProfilePage.routeName: (ctx) => UserProfilePage(),
        Settings.routeName: (ctx) => Settings(),
        About.routeName: (ctx) => About(),
        Rating.routeName: (ctx) => Rating(),
      },
    );
  }
}
