import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveAuction extends StatefulWidget {
  const LiveAuction({super.key});

  @override
  State<LiveAuction> createState() => _LiveAuctionState();
}

class _LiveAuctionState extends State<LiveAuction> {
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Palette.backgroundColor,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.70,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.blueColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "+ 500",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Palette.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
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
                                  style: TextStyle(color: Palette.whiteColor),
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
                                child: Text(
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
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.blueColor, // Adjust color as needed
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            color: Palette.greyColor)
                      ],
                    ),
                    child: const Center(
                      child: ImageIcon(
                        AssetImage("icons/bidlogo.png"),
                        size: 30,
                        color: Palette.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: "Comments"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .05,
            right: 25,
            child: SafeArea(
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.darkBlueColor,
                ),
                child: Center(
                  child: Text(
                    "01:02:31",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Palette.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .07,
            left: 25,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.greyColor.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.redColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("User 1")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 22,
                          child: Image.asset(
                            "icons/baht.png",
                            color: Palette.greenColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "1,200",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Palette.greenColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.01,
              left: 25,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.redColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Palette.whiteColor,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
