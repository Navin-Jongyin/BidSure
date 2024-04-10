import 'dart:async';
import 'dart:convert';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/model/live_msg_model.dart';
import 'package:bidsure_2/model/msg_widget.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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
  int socketUserId = 0;
  String socketUsername = "";
  IO.Socket? socket;
  List<LiveMsgModel> listMsg = [];
  TextEditingController _liveMsgController = TextEditingController();

  @override
  void initState() {
    getAuctionInfo();
    getBalance();
    getUserSocket();
    super.initState();
    connect();
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   // Update the UI by calling setState
    //   setState(() {
    //     getHighestPrice();

    //   });
    // });
  }

  Future<void> getUserSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/user/getusersocket';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final id = jsonData['userId'];
        final username = jsonData['username'];
        setState(() {
          socketUsername = username;
          socketUserId = id;
          print(socketUserId);
          print(socketUsername);
        });
      }
    }
  }

  Future<void> getAuctionInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl =
          'https://bidsure-backend.onrender.com/auction/getauctioninfo';
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
      String apiUrl =
          'https://bidsure-backend.onrender.com/bidding/createbidding';

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
    String apiUrl = 'https://bidsure-backend.onrender.com/bidding';
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
      String apiUrl =
          'https://bidsure-backend.onrender.com/topup/walletbalance';
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
          walletBalance = walletbalance.toString();
          print(walletBalance);
        });
      }
    }
  }

  void connect() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print("frontend connected");
      socket!.on("sendMsgServer", (msg) {
        print("Received message: $msg");
        try {
          if (msg != null && msg is Map<String, dynamic>) {
            final int id = msg['id'];
            final String? username = msg['username'];
            final String? receivedMsg = msg['msg'];
            if (username != null &&
                receivedMsg != null &&
                msg["userId"] != socketUserId &&
                msg["id"] == widget.id) {
              setState(() {
                listMsg.add(LiveMsgModel(
                  id: id,
                  msg: receivedMsg,
                  username: username,
                ));
              });
            } else {
              print(
                  "One of the properties is null: , sender=$username, receivedMsg=$receivedMsg");
            }
          } else {
            print("Invalid message format: $msg");
          }
        } catch (e, stackTrace) {
          print("Error processing message: $e");
          print(stackTrace);
        }
      });
    });
  }

  void sendMsg(int id, String msg, String userName) {
    LiveMsgModel ownMsg = LiveMsgModel(id: id, msg: msg, username: userName);
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      "id": id,
      "msg": msg,
      "username": userName,
      "userId": socketUserId,
    });
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
                left: 0,
                bottom: 80,
                child: Container(
                  width: 200,
                  height: 300,
                  child: ListView.builder(
                    reverse: true, // Reverse the order of children
                    itemCount: listMsg.length > 4
                        ? 4
                        : listMsg.length, // Show maximum 4 messages
                    itemBuilder: (context, index) {
                      final int reversedIndex = listMsg.length - 1 - index;
                      return MsgWidget(
                        msg: listMsg[reversedIndex].msg,
                        username: listMsg[reversedIndex].username,
                      );
                    },
                  ),
                ),
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
                          controller: _liveMsgController,
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
                        onTap: () {
                          String msg = _liveMsgController.text;
                          if (msg.isNotEmpty) {
                            sendMsg(widget.id, _liveMsgController.text,
                                socketUsername);
                            _liveMsgController.clear();
                            print(listMsg);
                          }
                        },
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
