import 'dart:ui';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOnlineAuction extends StatefulWidget {
  const NewOnlineAuction({super.key});

  @override
  State<NewOnlineAuction> createState() => _NewOnlineAuctionState();
}

class _NewOnlineAuctionState extends State<NewOnlineAuction> {
  final List<int> times = List.generate(10, (index) => index);
  int selectedTime = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "New Online Auction",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: TextField(
                    maxLength: 24,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkGreyColor),
                    cursorHeight: 20,
                    cursorColor: Palette.blueColor,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.greyColor,
                        ),
                      ),
                      labelText: "Item Name",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.blueColor),
                      ),
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      focusColor: Palette.blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: TextField(
                    maxLength: 80,
                    minLines: 5,
                    maxLines: 5,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkGreyColor),
                    cursorHeight: 20,
                    cursorColor: Palette.blueColor,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.greyColor,
                        ),
                      ),
                      labelText: "Item Description",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.blueColor),
                      ),
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      focusColor: Palette.blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Palette.darkGreyColor),
                          cursorHeight: 20,
                          cursorColor: Palette.blueColor,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Start Price",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                            floatingLabelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            focusColor: Palette.blueColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Palette.darkGreyColor),
                          cursorHeight: 20,
                          cursorColor: Palette.blueColor,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Minimum Bid",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                            floatingLabelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            focusColor: Palette.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Add Item Images",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.greyColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Palette.greyColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(25),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Theme(
                  data: ThemeData.dark(),
                  child: CupertinoAlertDialog(
                    title: const Text(
                      "Select Auction Duration",
                      style:
                          TextStyle(fontSize: 18, fontFamily: '.SF Pro Text'),
                    ),
                    content: SizedBox(
                      height: 100, // Set a fixed height for the container
                      child: ListWheelScrollView(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 40,
                        diameterRatio: 0.7, // Height of each item
                        children: times.map((int time) {
                          return Center(
                            child: Text(
                              '$time Hours',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedTime = times[index];
                          });
                        },
                      ),
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
                          "Select",
                          style: TextStyle(
                            color: Palette.blueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          print(selectedTime);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Palette.blueColor],
              ),
            ),
            child: Center(
              child: Text(
                "Continue",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
