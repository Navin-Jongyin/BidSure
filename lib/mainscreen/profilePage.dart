import 'package:bidsure_project/config/bottomNavBar.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:bidsure_project/mainscreen/newAuctionPage.dart';
import 'package:bidsure_project/mainscreen/searchPage.dart';
import 'package:bidsure_project/mainscreen/walletPage.dart';
import 'package:bidsure_project/mainscreen/myAuctionPage.dart';
import 'package:bidsure_project/settingscreen/settingsPage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "User Profile",
              style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Palette.redMainColor),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SettingsPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Palette.greyColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Align(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Palette.darkMainColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Text(
                    "Name Surename",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkMainColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("icons/auction.png"),
                      size: 35,
                    ),
                    title: Text("My Auction",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkMainColor,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const MyAuctionPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("icons/payment.png"),
                      size: 35,
                    ),
                    title: Text("Payment",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkMainColor,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios),

                    // onTap: (){
                    //   Navigator.of(context).pushReplacement(
                    //     PageRouteBuilder(
                    //       pageBuilder: (context, animation, secondaryAnimation) =>
                    //       const MyAuctionPage(),
                    //     ),
                    //   );
                    //
                    // },
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("icons/history.png"),
                      size: 35,
                    ),
                    title: Text("History",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkMainColor,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios),

                    // onTap: (){
                    //   Navigator.of(context).pushReplacement(
                    //     PageRouteBuilder(
                    //       pageBuilder: (context, animation, secondaryAnimation) =>
                    //       const MyAuctionPage(),
                    //     ),
                    //   );
                    //
                    // },
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("icons/shipping.png"),
                      size: 35,
                    ),
                    title: Text("Shipping Address",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkMainColor,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios),

                    // onTap: (){
                    //   Navigator.of(context).pushReplacement(
                    //     PageRouteBuilder(
                    //       pageBuilder: (context, animation, secondaryAnimation) =>
                    //       const MyAuctionPage(),
                    //     ),
                    //   );
                    //
                    // },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 150.0,
            margin: EdgeInsets.only(bottom: 50),
            child: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Palette.redMainColor,
              child: Text(
                "LOGOUT",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          setState(
            () {},
          );
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SearchPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CreateAuctionPage(),
              ),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WalletPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
