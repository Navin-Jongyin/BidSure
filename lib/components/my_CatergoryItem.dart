import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCategory extends StatelessWidget {
  final String imagePath;
  final String itemName;
  const MyCategory({
    super.key,
    required this.imagePath,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Palette.greyColor),
            ),
            child: Center(
              child: ImageIcon(
                AssetImage(imagePath),
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            itemName,
            style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Palette.greyColor),
          )
        ],
      ),
    );
  }
}
