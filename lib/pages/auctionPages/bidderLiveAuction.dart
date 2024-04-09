import 'dart:async';
import 'dart:convert';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BidderLiveAuction extends StatefulWidget {
  final int id;

  const BidderLiveAuction({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<BidderLiveAuction> createState() => _BidderLiveAuctionState();
}

class _BidderLiveAuctionState extends State<BidderLiveAuction> {
  String itemName = "";
  String itemDescription = "";
  List<String> images = [];
  String endTime = '';
  String minBid = "";
  String highestPrice = "";
  String walletBalance = "";
  String bidderName = "";
  final TextEditingController _priceController = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    getAuctionInfo();
    getBalance();

    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the UI by calling setState
      setState(() {
        getHighestPrice();
      });
    });
  }

  Future<void> getAuctionInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.43:3000/auction/getauctioninfo';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'auctionId': widget.id}),
      );
      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        final jsonData = data['data'];
        final name = jsonData['name'];
        final List<String> image =
            (jsonData['images'] as List).map((e) => e.toString()).toList();
        final itemDes = jsonData['description'];
        final minbid = jsonData['minBid'].toString();
        final endtime = jsonData['endTime'];
        setState(() {
          itemName = name;
          images = image;
          itemDescription = itemDes;
          endTime = endtime;
          minBid = minbid;
          print(minBid);
          print(itemName);
          print(endTime);
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<void> makeBid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.43:3000/bidding/createbidding';

      print(_priceController.text + "ASd");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {'id': widget.id, 'price': _priceController.text},
        ),
      );
      if (response.statusCode == 201) {
        print(response.body);

        final data = jsonDecode(response.body);
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<void> getHighestPrice() async {
    String apiUrl = 'http://192.168.1.43:3000/bidding';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'auctionId': widget.id,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      final jsonData = data['result'];
      final highest = jsonData['price'];
      final String bidder = jsonData['username'] as String? ?? "Starting Price";

      setState(() {
        highestPrice = highest;
        bidderName = bidder;
        print(highestPrice);
      });
    } else {
      print(response.statusCode);
      // print("getPrice Failed");
    }
  }

  Future<void> getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.43:3000/topup/walletbalance';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final walletbalance = jsonData['walletBalance'];
        setState(() {
          walletBalance = walletbalance;
          print(walletBalance);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "BidSure",
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
        child: Center(
          child: Stack(
            children: [
              const YoYoPlayer(
                aspectRatio: 9 / 16,
                url: "http://192.168.1.43:8000/live/test/index.m3u8",
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Palette.backgroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Palette.greyColor,
                          ),
                          cursorColor: Palette.blueColor,
                          decoration: InputDecoration(
                            hintText: "Comments",
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Palette.greyColor,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.greyColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.send,
                          color: Palette.blueColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: MediaQuery.sizeOf(context).height * 0.13,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Palette.greenColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Palette.greyColor,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              height: 350,
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                children: [
                                  Text(
                                    "MAKE A BID!",
                                    style: GoogleFonts.montserratAlternates(
                                      color: Palette.blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "You must enter the amount more than current highest bid and must be atleast minimum bid",
                                    style: GoogleFonts.montserrat(
                                      color: Palette.greyColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextField(
                                    controller: _priceController,
                                    cursorColor: Palette.blueColor,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      prefix: const ImageIcon(
                                        AssetImage("icons/baht.png"),
                                      ),
                                      hintText: "Enter Amount",
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Palette.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.blueColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.red.shade300,
                                                Palette.redColor
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Cancel",
                                              style: GoogleFonts.montserrat(
                                                color: Palette.whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          makeBid();
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade300,
                                                Palette.blueColor
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Place Bid",
                                              style: GoogleFonts.montserrat(
                                                color: Palette.whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "B I D",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  child: Container(
                padding: EdgeInsets.all(10),
                height: 60,
                color: Palette.darkGreyColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BidSure User : 10000",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Palette.whiteColor,
                      ),
                    ),
                    Text(
                      "00:00:00",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.whiteColor,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
