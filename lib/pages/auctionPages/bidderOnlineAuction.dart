import 'dart:async';
import 'dart:convert';

import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserOnlineAuction extends StatefulWidget {
  final int id;

  const UserOnlineAuction({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<UserOnlineAuction> createState() => _UserOnlineAuctionState();
}

class _UserOnlineAuctionState extends State<UserOnlineAuction> {
  final TextEditingController _controller = TextEditingController();
  String itemName = '';
  List<String> images = [];
  String itemDescription = '';
  String minBid = '';
  String baseUrl = 'http://192.168.1.43:3000';
  String endTime = '';
  String highestPrice = "";
  String? walletBalance = '';
  Timer? _timer;
  String? bidderName = '';

  @override
  void initState() {
    super.initState();
    getAuctionInfo();
    getBalance();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        getHighestPrice();
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the timer when the page is disposed
    _timer?.cancel();
    super.dispose();
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
          // print(minBid);
          // print(itemName);
          // print(endTime);
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

      print(_controller.text + "ASd");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {'id': widget.id, 'price': _controller.text},
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
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      baseUrl + images[index],
                      fit: BoxFit.cover, // Adjust the image fit as needed
                    );
                  },
                ),
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
              top: MediaQuery.of(context).size.height / 2 - 80,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                decoration: BoxDecoration(
                  color: Palette.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    const BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 2,
                        color: Palette.greyColor)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      endTime, //countdown clock
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.blueColor),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              bidderName!,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.darkGreyColor),
                            ),
                            Text(
                              highestPrice,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.darkGreyColor),
                            )
                          ],
                        ),
                        Text(
                          "New Bid + $minBid",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.darkGreyColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: MediaQuery.of(context).size.height / 2 + -80,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Palette.blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      itemDescription,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Palette.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  color: Palette.backgroundColor,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _controller,
                            cursorColor: Palette.blueColor,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                hintText: "Enter Amount",
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.greyColor))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (double.tryParse(highestPrice)! +
                                    double.tryParse(minBid)! >
                                double.tryParse(_controller.text)!) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        textAlign: TextAlign.center,
                                        "Bid Unsuccessful",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.redColor),
                                      ),
                                      content: Text(
                                        "Bidding amount must be more than current higheset price and minimum bid combine",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Palette.greyColor),
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Palette.redColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Retry",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.whiteColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            } else if (double.tryParse(walletBalance!)! <
                                double.tryParse(_controller.text)!) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        textAlign: TextAlign.center,
                                        "Insufficient Amount",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.redColor),
                                      ),
                                      content: Text(
                                        "Not enough money in the wallet. Please top up before making a bid",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Palette.greyColor),
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Palette.redColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Retry",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.whiteColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        textAlign: TextAlign.center,
                                        "Confirm Bid",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.blueColor),
                                      ),
                                      content: Text(
                                        "Once you confirm the process cannot be undone!",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Palette.greyColor),
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            //_controller.clear();

                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Palette.redColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.whiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            makeBid();
                                            //_controller.clear();121

                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Palette.blueColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Confirm",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.whiteColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade300,
                                  Palette.blueColor
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "BID",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Palette.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
