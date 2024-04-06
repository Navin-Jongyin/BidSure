import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserOnlineAuction extends StatefulWidget {
  const UserOnlineAuction({super.key});

  @override
  State<UserOnlineAuction> createState() => _UserOnlineAuctionState();
}

class _UserOnlineAuctionState extends State<UserOnlineAuction> {
  TextEditingController priceController = TextEditingController();
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
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              right: 20,
              child: GestureDetector(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.greenColor,
                  ),
                  child: Center(
                    child: ImageIcon(
                      AssetImage("icons/bidlogo.png"),
                      size: 40,
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: CupertinoAlertDialog(
                          title: const Text(
                            "Enter Price",
                            style: TextStyle(
                                fontSize: 18, fontFamily: '.SF Pro Text'),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Enter Price to Bid. Once press confirm the process cannot be undo",
                                style: TextStyle(
                                    fontSize: 13, fontFamily: '.SF Pro Text'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CupertinoTextField(
                                style:
                                    const TextStyle(color: Palette.whiteColor),
                                controller: priceController,
                                placeholder: "Enter Price",
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Palette.blueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(
                                "Place Bid",
                                style: TextStyle(
                                    color: Palette.blueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                print("Place Bid");
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
