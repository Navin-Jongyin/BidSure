import 'package:bidsure_project/config/bottomNavBar.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/profilePage.dart';
import 'package:bidsure_project/mainscreen/searchPage.dart';
import 'package:bidsure_project/mainscreen/walletPage.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Palette.redMainColor,
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
          // Your content for "Popular" tab
          Center(
            child: Text("Popular Tab Content"),
          ),
          // Your content for "Following" tab
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
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WalletPage(),
              ),
            );
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
