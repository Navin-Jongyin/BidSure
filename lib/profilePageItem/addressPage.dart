import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/profilePage.dart';
import 'package:bidsure_project/profilePageItem/addNewAddress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfilePage(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back,
                color: Palette.darkMainColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Shipping Address",
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Palette.redMainColor,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Palette.greyColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Test Address Name",
                        style: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Test Address Detail Line 1",
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                      Text(
                        "Test Address Detail Line 2",
                        style: GoogleFonts.montserrat(fontSize: 14),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.delete,
                    color: Palette.redMainColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          backgroundColor: Palette.redMainColor,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddNewAddress(),
              ),
            );
          },
          child: Text(
            "Add New Address",
            style: GoogleFonts.montserrat(
                color: Palette.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
