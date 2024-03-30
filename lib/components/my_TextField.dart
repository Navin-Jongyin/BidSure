import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  final bool showSuffix;
  final TextInputType keyboardType;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.prefixIcon,
      required this.showSuffix,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.greyColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: GoogleFonts.montserrat(
          fontSize: 15,
          color: Colors.grey,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: Palette.greyColor,
        focusColor: Palette.yellowColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.blueColor),
            borderRadius: BorderRadius.circular(10)),
        suffix: showSuffix
            ? GestureDetector(
                onTap: () {},
                child: Text(
                  "FORGOT",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.blueColor),
                ),
              )
            : null,
      ),
      cursorColor: Palette.blueColor,
      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
    );
  }
}
