import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_CatergoryItem.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Search",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  cursorColor: Palette.blueColor,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Palette.greyColor),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Palette.blueColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.greyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.greyColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Category",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.greyColor,
                    fontWeight: FontWeight.w500),
              ),
              MyCategory(
                imagePath: "icons/category/equipment.png",
                itemName: "Sports",
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          setState(() {});
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          } else if (index == 2) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return MyBottomModal();
              },
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
