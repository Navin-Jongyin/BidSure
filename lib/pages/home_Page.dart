import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';

import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        children: const [
          Center(
            child: Text("Popular Tab Content"),
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
