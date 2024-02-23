import 'package:bidsure_project/config/bottomNavBar.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:bidsure_project/mainscreen/myAuctionPage.dart';
import 'package:bidsure_project/mainscreen/newAuctionPage.dart';
import 'package:bidsure_project/mainscreen/searchPage.dart';
import 'package:bidsure_project/mainscreen/walletPage.dart';
import 'package:bidsure_project/profilePageItem/addressPage.dart';
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
        shadowColor: Palette.darkMainColor,
        backgroundColor: Palette.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            icon: const Icon(
              Icons.settings,
              color: Palette.darkMainColor,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Palette.darkMainColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Name Surname",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Palette.darkMainColor,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Flexible(
              child: ListView(
                children: [
                  buildListTile(
                    "My Auction",
                    Icons.handshake,
                    Palette.darkMainColor,
                    () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const MyAuctionPage(),
                        ),
                      );
                    },
                  ),
                  buildListTile(
                    "My Card",
                    Icons.credit_card,
                    Palette.darkMainColor,
                    () {},
                  ),
                  buildListTile(
                    "History",
                    Icons.history,
                    Palette.darkMainColor,
                    () {},
                  ),
                  buildListTile(
                    "Shipping Address",
                    Icons.location_city,
                    Palette.darkMainColor,
                    () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const AddressPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
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

  ListTile buildListTile(String title, IconData icon, Color textColor,
      VoidCallback onTapCallBack) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
      ),
      onTap: onTapCallBack,
      trailing: const Icon(
        Icons.arrow_forward_ios, // Right arrow icon
        color: Palette.redMainColor,
      ),
    );
  }
}
