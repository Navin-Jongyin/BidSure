import 'package:bidsure_project/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.greyColor),
            borderRadius: BorderRadius.circular(10)),
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.redMainColor,
          ),
        ),
        focusColor: Palette.redMainColor,
      ),
    );
  }
}
