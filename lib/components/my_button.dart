import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color buttonColor;

  const MyButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Palette.darkBlueColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
