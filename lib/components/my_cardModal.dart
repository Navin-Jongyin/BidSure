import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCardList extends StatelessWidget {
  final String imagePath;
  final String cardNumber;
  final String expDate;
  const MyCardList({
    super.key,
    required this.imagePath,
    required this.cardNumber,
    required this.expDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Palette.greyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 35,
            height: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Expired : $expDate",
                style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Palette.redColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
