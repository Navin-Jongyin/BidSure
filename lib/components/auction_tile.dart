import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuctionTile extends StatelessWidget {
  final String networkImage;
  const AuctionTile({super.key, required this.networkImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 250,
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Palette.whiteColor,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: 1,
              blurRadius: 3,
              color: Palette.greyColor)
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Palette.blueColor,
            child: Center(
              child: Image.network(
                networkImage,
                fit: BoxFit.fitHeight,
              ),
            ),
          )
        ],
      ),
    );
  }
}
