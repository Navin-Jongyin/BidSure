import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAuctionPage extends StatefulWidget {
  const MyAuctionPage({Key? key}) : super(key: key);

  @override
  State<MyAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<MyAuctionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabTitles = ["Live Auction", "Online Auction"];

  int maxCharacterLimit = 250;
  int maxNameLimit = 25;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabTitles.length,
      vsync: this,
      initialIndex: 0, // Set the initial index
    );

    // Listen to tab changes and update the title accordingly
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
            InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Palette.greyColor,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfilePage(),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "My Auction",
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                color: Palette.redMainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Palette.redMainColor,
          unselectedLabelColor: Palette.greyColor,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(
              child: Text("Live Auction"),
            ),
            Tab(
              child: Text("Online Auction"),
            ),
          ],
        ),
      ),
    );
  }
}
