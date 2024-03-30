import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/new_LiveAuction.dart';
import 'package:bidsure_2/pages/auctionPages/new_OnlineAuction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBottomModal extends StatefulWidget {
  const MyBottomModal({super.key});

  @override
  State<MyBottomModal> createState() => _MyBottomModalState();
}

class _MyBottomModalState extends State<MyBottomModal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 180,
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const NewOnlineAuction(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 120,
                    width: 165,
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.blueColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageIcon(
                            AssetImage("icons/online_auc.png"),
                            size: 50,
                          ),
                          Text(
                            "Online Auction",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const NewLiveAuction(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 120,
                    width: 165,
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.blueColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageIcon(
                            AssetImage("icons/liveAuction.png"),
                            size: 50,
                          ),
                          Text(
                            "Live Auction",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
