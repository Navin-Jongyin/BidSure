import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/bidderOnlineAuction.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyAuction extends StatefulWidget {
  const MyAuction({super.key});

  @override
  State<MyAuction> createState() => _MyAuctionState();
}

class _MyAuctionState extends State<MyAuction> {
  String imageUrl = "";
  List<int> onlineAuctionIdList = [];
  List<String> onlineItemNameList = [];
  List<String> onlineItemDescriptionList = [];
  List<String> onlineStartingPriceList = [];
  List<String> onlineMinBidList = [];
  List<String> onlineEndTimeList = [];
  List<String> onlineItemImagesList = [];
  List<String> onlineUsernameList = [];
  List<String> onlineUserImageList = [];
  List<dynamic> onlineLength = [];
  Timer? _timer;

  String usernames = "";
  String highestPrice = "";
  String bidderName = "";
  int? bidID;

  @override
  void initState() {
    super.initState();

    getOnlineAuctionDetail();
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'https://bidsure-backend.onrender.com/';
        final jsonData = jsonDecode(response.body);
        final username = jsonData['username'];

        setState(() {
          usernames = username ?? "";
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<void> deleteAuction(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl =
          'https://bidsure-backend.onrender.com/auction/deleteauction';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'auctionId': index}),
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    }
  }

  Future<void> getHighestPrice(int index) async {
    String apiUrl = 'https://bidsure-backend.onrender.com/bidding';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'auctionId': index,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      final jsonData = data['result'];
      final highest = jsonData['price'];
      final String bidder = jsonData['username'] as String? ?? "Starting Price";
      final int bidId = jsonData['id'] == null ? 0 : jsonData['id'];

      setState(() {
        highestPrice = highest;
        bidderName = bidder;
        bidID = bidId;
        print(bidId);
        print(highestPrice);
      });
    } else {
      print(response.statusCode);
      // print("getPrice Failed");
    }
  }

  Future<void> makeTransactions(int id, int auctionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int auction = auctionId;
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl =
          "https://bidsure-backend.onrender.com/transection/createtransection";
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
            {
              'winBidId': id,
            },
          ));
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
        print(response.statusCode);
      }
    }
    await deleteAuction(auction);
  }

  Future<void> getOnlineAuctionDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/auction/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      final baseUrl = 'https://bidsure-backend.onrender.com';
      imageUrl = baseUrl;

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        List<dynamic> online = data['online'];

        setState(() {
          onlineLength = online;
          onlineAuctionIdList =
              online.map((item) => int.parse(item['id'].toString())).toList();
          onlineItemNameList =
              online.map((item) => item['name'].toString()).toList();
          onlineItemDescriptionList =
              online.map((item) => item['description'].toString()).toList();
          onlineStartingPriceList =
              online.map((item) => item['startingPrice'].toString()).toList();
          onlineMinBidList =
              online.map((item) => item['minBid'].toString()).toList();
          onlineEndTimeList =
              online.map((item) => item['endTime'].toString()).toList();
          onlineItemImagesList =
              online.map((item) => item['images'].toString()).toList();
          onlineUsernameList = online
              .map((item) => item['user']['username'].toString())
              .toList();
          onlineUserImageList =
              online.map((item) => item['user']['image'].toString()).toList();
          print(onlineItemImagesList);
          print(onlineItemImagesList[0]);
        });
      } else {
        setState(() {
          onlineAuctionIdList.clear();
          onlineItemNameList.clear();
          onlineItemDescriptionList.clear();
          onlineStartingPriceList.clear();
          onlineMinBidList.clear();
          onlineEndTimeList.clear();
          onlineItemImagesList.clear();
          onlineUsernameList.clear();
          onlineUserImageList.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "My Auctions",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: onlineLength.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Check if the username matches the logged in user's username
              bool isMatching = onlineUsernameList[index] == usernames;

              if (isMatching) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Palette.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        color: Palette.greyColor,
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            imageUrl +
                                onlineItemImagesList[index]
                                    .replaceAll('[', "")
                                    .replaceAll(']', "")
                                    .split(',')[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        onlineItemNameList[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Palette.blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "New Bid: +${onlineMinBidList[index]}",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Palette.greyColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        onlineEndTimeList[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Palette.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          getHighestPrice(onlineAuctionIdList[index]);
                          setState(() {});
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(25),
                                  height: 550,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Palette.redColor,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Palette.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 250,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Image.network(
                                          imageUrl +
                                              onlineItemImagesList[index]
                                                  .replaceAll('[', "")
                                                  .replaceAll(']', "")
                                                  .split(',')[0],
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        onlineItemNameList[index],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.blueColor,
                                        ),
                                      ),
                                      Text(
                                        onlineItemDescriptionList[index],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Palette.greyColor,
                                        ),
                                      ),
                                      Text(
                                        "New Bid: +${onlineMinBidList[index]}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Palette.greyColor,
                                        ),
                                      ),
                                      Text(
                                        "Current Highest: $highestPrice",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.redColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 50,
                                        width: 300,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Theme(
                                                  data: ThemeData.dark(),
                                                  child: CupertinoAlertDialog(
                                                    title: Text(
                                                      "End Auction?",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            '.SF Pro Text',
                                                      ),
                                                    ),
                                                    content: Text(
                                                      "After ending the auction will be deleted",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              '.SF Pro Text'),
                                                    ),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  '.SF Pro Text',
                                                              color: Palette
                                                                  .blueColor),
                                                        ),
                                                      ),
                                                      CupertinoDialogAction(
                                                        child: Text(
                                                          "End",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  '.SF Pro Text',
                                                              color: Palette
                                                                  .redColor),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            makeTransactions(
                                                                bidID!,
                                                                onlineAuctionIdList[
                                                                    index]);
                                                          });
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                            PageRouteBuilder(
                                                              pageBuilder: (context,
                                                                      animation,
                                                                      secondaryAnimation) =>
                                                                  const MyAuction(),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          backgroundColor: Palette.redColor,
                                          child: Center(
                                            child: Text(
                                              "End Auction",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Palette.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade300, Palette.blueColor],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Details",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Palette.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                // If username doesn't match, return an empty container
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
