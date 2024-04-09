import 'dart:convert';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _numberController = TextEditingController();
  late WebViewController webController = WebViewController();
  String stripeUrl = "";

  Future<void> topUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'https://bidsure-backend.onrender.com/topup/checkout';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(
        {'price': _numberController.text},
      ),
    );
    final jsonData = jsonDecode(response.body);
    final getStripeUel = jsonData['link'];
    stripeUrl = getStripeUel;

    if (response.statusCode == 200) {
      print("success");

      print(stripeUrl);
    } else {
      print("error");
      print(response.body);
      print(stripeUrl);
    }
  }

  Future<void> stripePage() async {
    webController = WebViewController()..loadRequest(Uri.parse(stripeUrl));
  }

  void initState() {
    super.initState();
    stripePage();
    topUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Top Up",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WalletPage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.blueColor,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.blueColor,
                            Colors.blue.shade300,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "BidSure Wallet",
                            style: GoogleFonts.montserratAlternates(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Palette.whiteColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Current Balance",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Palette.whiteColor),
                              ),
                              Row(
                                children: [
                                  const ImageIcon(
                                    AssetImage(
                                      "icons/baht.png",
                                    ),
                                    color: Palette.whiteColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "0.00",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.whiteColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter Top Up Amount",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Palette.greyColor,
                      fontWeight: FontWeight.w500),
                ),
                TextField(
                  controller: _numberController,
                  cursorColor: Palette.blueColor,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Palette.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.blueColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (_numberController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: CupertinoAlertDialog(
                              title: Text("Please Enter Amount"),
                              content: Text("Please enter at least 1 baht"),
                              actions: [],
                            ),
                          );
                        },
                      );
                    } else {
                      topUp();
                      stripePage();
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade300,
                            Palette.blueColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Top Up",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Palette.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
