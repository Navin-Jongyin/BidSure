import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/liveStreamAuction.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOnlineAuction extends StatefulWidget {
  const NewOnlineAuction({Key? key}) : super(key: key);

  @override
  State<NewOnlineAuction> createState() => _NewOnlineAuctionState();
}

class _NewOnlineAuctionState extends State<NewOnlineAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "New Online Auction",
          backButton: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        child: TextField(
                          cursorColor: Palette.blueColor,
                          maxLength: 24,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: "Item Name",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 14,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.greyColor),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                            focusColor: Palette.blueColor,
                            floatingLabelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Palette.blueColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        cursorColor: Palette.blueColor,
                        maxLength: 80,
                        minLines: 5,
                        maxLines: 5,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          labelText: "Item Details",
                          labelStyle: GoogleFonts.montserrat(fontSize: 14),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.greyColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Palette.blueColor),
                          ),
                          focusColor: Palette.blueColor,
                          floatingLabelStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Palette.blueColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                height: 70,
                                child: TextField(
                                  cursorColor: Palette.blueColor,
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.greyColor),
                                    ),
                                    labelText: "Starting Price",
                                    labelStyle: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Palette.greyColor,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.blueColor),
                                    ),
                                    focusColor: Palette.blueColor,
                                    floatingLabelStyle: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Palette.blueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height: 70,
                                child: TextField(
                                  cursorColor: Palette.blueColor,
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.greyColor),
                                    ),
                                    labelText: "New Bid",
                                    labelStyle: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Palette.greyColor,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.blueColor),
                                    ),
                                    floatingLabelStyle: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Palette.blueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Image",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Palette.darkGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.blue.shade300, Palette.blueColor],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Start Auction",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
