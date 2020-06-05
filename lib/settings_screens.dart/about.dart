import 'package:chat/screens/home_screen.dart';
import 'package:chat/settings_screens.dart/rating.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  static const routeName = 'about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width - 70,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 50, blurRadius: 30)
                ],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.yellow,
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/fluchat-cf0a6.appspot.com/o/user_profile_picture%2Ficon.png?alt=media&token=75991835-5fa7-45a7-9a49-4efd65746376')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Sirsho Chakraborty',
                      style: GoogleFonts.montserrat(
                          color: Colors.black87, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Flutter Developer',
                      style: GoogleFonts.montserrat(
                          color: Colors.lightBlue, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(
                      '',
                      style: GoogleFonts.montserrat(
                          color: Colors.black87, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Follow : ',
                          style: GoogleFonts.montserrat(
                              color: Colors.black45, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () async {
                            const url = 'https://github.com/Sirsho29';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'https://github.com/Sirsho29',
                            style: GoogleFonts.montserrat(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                    indent: 100,
                    endIndent: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, top: 5, bottom: 5),
                        child: Text(
                          'Email ID',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 13.0, top: 5, bottom: 5),
                        child: Text(
                          'sirsha.cse@gmail.com',
                          style: GoogleFonts.montserrat(
                              color: Colors.black45, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, top: 5, bottom: 5),
                        child: Text(
                          'Phone',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 13.0, top: 5, bottom: 5),
                        child: Text(
                          '9163599295',
                          style: GoogleFonts.montserrat(
                              color: Colors.black45, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black54,
                    indent: 100,
                    endIndent: 100,
                  ),
                  MaterialButton(
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Rate fluR',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                      elevation: 6,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Rating.routeName);
                      }),
                ],
              ),
            )),
            SizedBox(height: 30),
            IconButton(
                icon: Icon(
                  Typicons.arrow_left_outline,
                  size: 40,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                })
          ],
        ),
      ),
    );
  }
}
