import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/profilePageItem/addressPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AddressPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Add New Address",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Palette.redMainColor),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Person",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.darkMainColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
