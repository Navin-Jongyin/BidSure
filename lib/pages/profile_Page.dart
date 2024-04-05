import 'dart:convert';

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullname = "";
  String usernamee = "";
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.39:3000/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'http://192.168.1.39:3000/';
        final jsonData = jsonDecode(response.body);
        final name = jsonData['fullname'];
        final username = jsonData['username'];
        final image = jsonData['image'];

        print(name + username);

        setState(() {
          fullname = name;
          usernamee = username;
          imagePath = baseUrl + image;
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

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
                margin: EdgeInsets.all(15),
                child: ClipOval(
                  child: imagePath.isNotEmpty
                      ? Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        )
                      : Image.asset(
                          "icons/avatar.png",
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        ),
                ),
              ),
              Text(
                fullname,
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text("@" + usernamee,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Palette.blueColor)),
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
                title: "Won Item",
                imagePath: "icons/bidwon.png",
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
