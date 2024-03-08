import 'package:bidsure_project/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Palette.darkMainColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Wallet Top Up",
              style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  color: Palette.redMainColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
