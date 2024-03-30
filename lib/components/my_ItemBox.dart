import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyItem extends StatelessWidget {
  const MyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 165,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Palette.greyColor,
            ),
            child: const Center(
              child: Text(
                "Test Image",
                style: TextStyle(color: Palette.whiteColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Item Name",
            style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Palette.greyColor,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Bid",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Palette.greyColor,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "+THB 000",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Palette.yellowColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Highest",
                style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: Palette.greyColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "THB 2500",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Palette.redColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Time Remaining",
                style: GoogleFonts.montserrat(
                    fontSize: 8,
                    color: Palette.greyColor,
                    fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
