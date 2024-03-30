import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Shipping Address",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
          iconData: Icons.add,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(15),
              height: 120,
              width: double.infinity,
              color: Palette.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name Surname",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.blueColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 15,
                        color: Palette.darkGreyColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "081-123-1234",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.darkGreyColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_city),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Address",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.darkGreyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
