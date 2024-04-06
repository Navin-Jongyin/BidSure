import 'dart:convert';

import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:http/http.dart' as http;
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getAuction();
  }

  Future<void> getAuction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.39:3000/auction/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // print(response.body);
        final baseUrl = 'http://192.168.1.39:3000';
        final jsonData = jsonDecode(response.body);

        final auctionitem = jsonData['data'][0];
        final owener = auctionitem['user'];
        final username = owener['username'];
        final userImage = owener['image'];

        final itemname = auctionitem['name'];
        final itemdes = auctionitem['description'];
        final startpr = auctionitem['startingPrice'];
        final minimum = auctionitem['minBid'];
        final itemImage =
            'http://192.168.1.39:3000/auctionImages/1712418986512-886636526-image_picker_3D13017F-BB83-48E3-9D70-D4C4AF069AAA-4800-000002297874ABCF.jpg';

        print(itemImage);
        print(minimum);
        print(itemname);
        print(itemdes);
        print(startpr);
        print(owener);
        imagePath = itemImage;
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.whiteColor,
        title: TabBar(
          controller: _tabController,
          indicator: null,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelColor: Palette.blueColor,
          unselectedLabelColor: Palette.greyColor,
          labelStyle: GoogleFonts.montserratAlternates(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.montserratAlternates(
              fontSize: 15, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(
              child: Text(
                "Popular",
              ),
            ),
            Tab(
              child: Text(
                "Following",
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Palette.backgroundColor, // Set container color to white
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.width * 0.75,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Palette.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Palette.blueColor),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                      ),
                      // Your content here
                    ),
                  ),
                  // Add more widgets here if needed
                ],
              ),
            ),
          ),
          Center(
            child: Text("Following Tab Content"),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(
            () {},
          );
          if (index == 1) {
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
          } else if (index == 4) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
