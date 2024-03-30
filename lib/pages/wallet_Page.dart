import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/my_cardModal.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/search_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MyAppBar(
          appBarTitle: "Wallet",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            25,
          ),
          child: Column(
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
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Select your card",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.greyColor),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Palette.blueColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const MyCardList(
                                imagePath: "icons/visa.webp",
                                cardNumber: "4162 xxxx xxxx 7642",
                                expDate: "05/24",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const MyCardList(
                                imagePath: "icons/mastercard.png",
                                cardNumber: "5123 xxxx xxxx 1234",
                                expDate: "07/25",
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Palette.blueColor,
                                        Colors.blue.shade300
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Palette.whiteColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.blueColor, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Top Up",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Palette.blueColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Transactions History",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.greyColor,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          setState(
            () {},
          );
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          } else if (index == 1) {
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
                  return MyBottomModal();
                });
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
