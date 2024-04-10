import 'dart:convert';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/bidderLiveAuction.dart';
import 'package:bidsure_2/pages/auctionPages/bidderOnlineAuction.dart';
import 'package:bidsure_2/pages/auctionPages/liveStreamAuction.dart';
import 'package:bidsure_2/pages/auctionPages/onlineAuction.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player_web_hls/hls.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  List<int> liveAuctionIdList = [];
  List<String> liveItemNameList = [];
  List<String> liveItemDescriptionList = [];
  List<String> liveStartingPriceList = [];
  List<String> liveMinBidList = [];
  List<String> liveEndTimeList = [];
  List<String> liveItemImagesList = [];
  List<String> liveUsernameList = [];
  List<String> liveUserImageList = [];
  List<dynamic> liveLength = [];
  String userName = "";

  @override
  void initState() {
    super.initState();
    getOnlineAuctionDetail();
    getLiveAuctionDetail();
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
          userName = username;
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<void> getLiveAuctionDetail() async {
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
      final baseUrl = 'https://bidsure-backend.onrender.com';
      imageUrl = baseUrl;

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        List<dynamic> live = data['live'];
        setState(() {
          liveLength = live;
          liveAuctionIdList =
              live.map((item) => int.parse(item['id'].toString())).toList();
          liveItemNameList =
              live.map((item) => item['name'].toString()).toList();
          liveItemDescriptionList =
              live.map((item) => item['description'].toString()).toList();
          liveStartingPriceList =
              live.map((item) => item['startingPrice'].toString()).toList();
          liveMinBidList =
              live.map((item) => item['minBid'].toString()).toList();
          liveEndTimeList =
              live.map((item) => item['endTime'].toString()).toList();
          liveItemImagesList =
              live.map((item) => item['images'].toString()).toList();
          liveUsernameList =
              live.map((item) => item['user']['username'].toString()).toList();
          liveUserImageList =
              live.map((item) => item['user']['image'].toString()).toList();
          print(liveItemNameList);
        });
      } else {
        setState(() {
          liveAuctionIdList.clear();
          liveItemNameList.clear();
          liveItemDescriptionList.clear();
          liveStartingPriceList.clear();
          liveMinBidList.clear();
          liveEndTimeList.clear();
          liveItemImagesList.clear();
          liveUsernameList.clear();
          liveUserImageList.clear();
          liveUserImageList.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        title: const MyAppBar(
          appBarTitle: "BidSure",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Online Auction",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Palette.greyColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onlineLength.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        bool isNotMatching =
                            onlineUsernameList[index] != userName;
                        if (isNotMatching) {
                          Container(
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
                                                  .split(',')[
                                              0], // Replace 'placeholder_image_url' with your placeholder image URL or handle it accordingly
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Palette
                                                                    .redColor),
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Palette
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 250,
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: Image.network(
                                                      imageUrl +
                                                          onlineItemImagesList[
                                                                  index]
                                                              .replaceAll(
                                                                  '[', "")
                                                              .replaceAll(
                                                                  ']', "")
                                                              .split(',')[0],
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    onlineItemNameList[index],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Palette
                                                                .blueColor),
                                                  ),
                                                  Text(
                                                    onlineItemDescriptionList[
                                                        index],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Palette
                                                                .greyColor),
                                                  ),
                                                  Text(
                                                    "New Bid: +${onlineMinBidList[index]}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Palette
                                                                .greyColor),
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 300,
                                                    child: FloatingActionButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserOnlineAuction(
                                                              id: onlineAuctionIdList[
                                                                  index], // Pass the auction ID to the next page as a List
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          25,
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Palette.blueColor,
                                                      child: Center(
                                                        child: Text(
                                                          "Join Auction",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Palette
                                                                      .whiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade300,
                                          Palette.blueColor
                                        ],
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
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Live Auction",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Palette.greyColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: liveLength.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          bool isNotmatching =
                              liveUsernameList[index] != userName;
                          if (isNotmatching) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        imageUrl +
                                            liveItemImagesList[index]
                                                .replaceAll('[', "")
                                                .replaceAll(']', ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    liveItemNameList[index],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Palette.blueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "New Bid: +${liveMinBidList[index]}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Palette.greyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    liveEndTimeList[index],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 11,
                                      color: Palette.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                height: 550,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Palette
                                                                      .redColor),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Palette
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        imageUrl +
                                                            liveItemImagesList[
                                                                    index]
                                                                .replaceAll(
                                                                    '[', "")
                                                                .replaceAll(
                                                                    ']', "")
                                                                .split(',')[0],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      liveItemNameList[index],
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Palette
                                                                  .blueColor),
                                                    ),
                                                    Text(
                                                      liveItemDescriptionList[
                                                          index],
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Palette
                                                                  .greyColor),
                                                    ),
                                                    Text(
                                                      "New Bid: +${liveMinBidList[index]}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Palette
                                                                  .greyColor),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      height: 50,
                                                      width: 300,
                                                      child:
                                                          FloatingActionButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BidderLiveAuction(
                                                                id: liveAuctionIdList[
                                                                    index], // Pass the auction ID to the next page as a List
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            25,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Palette.blueColor,
                                                        child: Center(
                                                          child: Text(
                                                            "Join Auction",
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Palette
                                                                    .whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade300,
                                            Palette.blueColor
                                          ],
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
                            return Container();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() {});
          if (index == 1) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SearchPage(),
              ),
            );
          } else if (index == 2) {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const MyBottomModal();
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
