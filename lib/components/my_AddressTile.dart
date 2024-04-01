import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/subpages/edit_Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAddressTile extends StatelessWidget {
  final String name;
  final String addressDetail;
  final String phoneNumber;
  const MyAddressTile({
    super.key,
    required this.addressDetail,
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Palette.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Palette.greyColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Palette.blueColor,
                ),
              ),
              Row(
                children: [
                  const ImageIcon(
                    AssetImage("icons/address.png"),
                    size: 15,
                    color: Palette.blueColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    addressDetail,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Palette.greyColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const ImageIcon(
                    AssetImage("icons/mobile.png"),
                    size: 15,
                    color: Palette.blueColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    phoneNumber,
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const EditAddress(),
                ),
              );
            },
            child: const ImageIcon(
              AssetImage("icons/edit.png"),
              size: 20,
              color: Palette.darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
