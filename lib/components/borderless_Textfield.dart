import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BorderlessTextField extends StatelessWidget {
  final String labelText;
  const BorderlessTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Palette.darkGreyColor),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Palette.greyColor,
          ),
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          color: Palette.blueColor,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Palette.blueColor,
          ),
        ),
        focusColor: Palette.blueColor,
      ),
    );
  }
}
