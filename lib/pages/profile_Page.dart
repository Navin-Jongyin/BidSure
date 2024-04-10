import 'dart:async';
import 'dart:convert';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/my_listTile.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:bidsure_2/pages/subpages/following_List.dart';
import 'package:bidsure_2/pages/subpages/myAuctions.dart';
import 'package:bidsure_2/pages/subpages/my_Card.dart';
import 'package:bidsure_2/pages/subpages/shipping_Address.dart';
import 'package:bidsure_2/pages/subpages/wonItems.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? fullname = "";
  String? usernamee = "";
  String imagePath = "";
  String? bio = "";
  List<String?> followingNumbers = [];
  List<String?> followerNumbers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getUser();
    getfollowing();
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   // Update the UI by calling setState
    //   setState(() {
    //     getfollowing();
    //   });
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call getUser() whenever dependencies change
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'https://bidsure-backend.onrender.com/';
        final jsonData = jsonDecode(response.body);
        final name = jsonData['fullname'];
        final username = jsonData['username'];
        final image = jsonData['image'];
        final userbio = jsonData['bio'];

        print(name + username);

        setState(() {
          fullname = name ?? "";
          usernamee = username ?? "";
          imagePath = baseUrl + image;
          bio = userbio ?? "";
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<void> getfollowing() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'https://bidsure-backend.onrender.com';
        final jsonData = jsonDecode(response.body);
        final name = jsonData['fullname'];
        final pic = jsonData['image'];
        final List<dynamic?> following = jsonData['following'];
        final List<dynamic?> follower = jsonData['follower'];
        final List<String> followingNumber =
            following.map((item) => item.toString()).toList();
        imagePath = baseUrl + pic;
        final List<String> followerNumber =
            follower.map((item) => item.toString()).toList();

        // print(name);
        // print(pic);
        // print(imagePath);
        // print(following);
        print(followingNumber.length);

        setState(() {
          fullname = name;
          imagePath = imagePath;
          followingNumbers = followingNumber;
          followerNumbers = followerNumber;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: ClipOval(
                    child: imagePath != null && imagePath.isNotEmpty
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
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Follower",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Palette.blueColor),
                            ),
                            Text(
                              followerNumbers.length.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: Palette.darkGreyColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const MyFollowing(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Following",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Palette.blueColor),
                            ),
                            Text(
                              followingNumbers != null
                                  ? followingNumbers.length.toString()
                                  : "0",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: Palette.darkGreyColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  fullname ?? "",
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  "@" + usernamee! ?? "",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Palette.blueColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    bio ?? "",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkGreyColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Divider(
                    color: Palette.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyListTile(
                  title: "My Auctions",
                  imagePath: "icons/auction.png",
                  color: Palette.greyColor,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MyAuction(),
                      ),
                    );
                  },
                ),
                MyListTile(
                  title: "Won Item",
                  imagePath: "icons/bidwon.png",
                  color: Palette.greyColor,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const WonItem(),
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
              ],
            ),
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
