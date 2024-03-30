import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/my_listTile.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';

import 'package:bidsure_2/pages/home_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:bidsure_2/pages/subpages/my_Card.dart';
import 'package:bidsure_2/pages/subpages/shipping_Address.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
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
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "User Profile",
          iconData: Icons.settings_outlined,
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SettingsPage(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Palette.greyColor,
                    borderRadius: BorderRadius.circular(60)),
              ),
              Text(
                "Name Username",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              MyListTile(
                title: "My Auctions",
                imagePath: "icons/auction.png",
                color: Palette.greyColor,
                onTap: () {},
              ),
              MyListTile(
                title: "My Card",
                imagePath: "icons/card.png",
                color: Palette.greyColor,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MyCard(),
                    ),
                  );
                },
              ),
              MyListTile(
                title: "Shipping Address",
                imagePath: "icons/shipping.png",
                color: Palette.greyColor,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ShippingAddress(),
                    ),
                  );
                },
              ),
              MyListTile(
                title: "History",
                imagePath: "icons/history.png",
                color: Palette.greyColor,
                onTap: () {},
              ),
              MyListTile(
                title: "Favourite",
                imagePath: "icons/favourite.png",
                color: Palette.greyColor,
                onTap: () {},
              ),
            ],
          ),
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
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return MyBottomModal();
                });
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
