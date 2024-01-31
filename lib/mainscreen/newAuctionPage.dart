import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({super.key});

  @override
  State<CreateAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
            IconButton(
              onPressed: (() {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                  ),
                );
              }),
              icon: const Icon(
                Icons.arrow_back,
                color: Palette.darkMainColor,
              ),
            ),
            Text(
              "Create New Auction",
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                color: Palette.redMainColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "Item Name",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Palette.redMainColor),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
