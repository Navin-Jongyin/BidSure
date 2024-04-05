import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineAuction extends StatefulWidget {
  const OnlineAuction({super.key});

  @override
  State<OnlineAuction> createState() => _OnlineAuctionState();
}

class _OnlineAuctionState extends State<OnlineAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Palette.backgroundColor,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.maxFinite,
                color: Palette.greyColor,
              ),
            ),
            Positioned(
              top: 15,
              left: 25,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.redColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        color: Palette.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 25,
              right: 25,
              top: MediaQuery.of(context).size.height / 2 - 40,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Palette.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                      color: Palette.greyColor,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: double.maxFinite,
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Highest",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Palette.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "12500",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    SizedBox(
                      height: double.maxFinite,
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "New Bid",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Palette.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "+ 500",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    SizedBox(
                      height: double.maxFinite,
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Time Left",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Palette.redColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "05:23:12",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: MediaQuery.of(context).size.height / 2 + -60,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recents Bid",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
