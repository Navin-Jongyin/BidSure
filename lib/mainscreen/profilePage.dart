import 'package:bidsure_project/config/bottomNavBar.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:bidsure_project/mainscreen/newAuctionPage.dart';
import 'package:bidsure_project/mainscreen/searchPage.dart';
import 'package:bidsure_project/mainscreen/walletPage.dart';
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
          Container(
            child: Align(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align rows in the center horizontally
                children: [
                  const SizedBox(width: 80),

                  const ImageIcon(AssetImage("icons/auction.png"), size: 40),
                  const SizedBox(width: 30),
                  Text(
                    "My Auction",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.darkMainColor,
                    ),
                  ),

                  // Icon(Icons.navigate_next_sharp, color: Colors.redAccent),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Align(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align rows in the center horizontally
                children: [
                  const SizedBox(width: 80),
                  const ImageIcon(
                    AssetImage("icons/payment.png"),
                    size: 40,
                  ),
                  const SizedBox(width: 30),

                  Text(
                    "Payment",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.darkMainColor,
                    ),
                  ),

                  // Icon(Icons.navigate_next_sharp, color: Colors.redAccent),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Align(
              child: Row(
                children: [
                  const SizedBox(width: 80),
                  const ImageIcon(AssetImage("icons/history.png"), size: 40),
                  const SizedBox(width: 30),
                  Text(
                    "History",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.darkMainColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Align(
              child: Row(
                children: [
                  const SizedBox(width: 80),
                  const ImageIcon(AssetImage("icons/shipping.png"), size: 40),
                  const SizedBox(width: 30),
                  Text(
                    "Shipping Address",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.darkMainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 80),
          Container(
            width: 150.0,
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
          )
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
