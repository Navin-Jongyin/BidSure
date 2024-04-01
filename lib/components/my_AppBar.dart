import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  final String appBarTitle;
  final void Function()? onTap;
  final IconData? iconData;
  final void Function()? backButton;
  final IconData? backIcon;

  const MyAppBar({
    Key? key,
    required this.appBarTitle,
    this.onTap,
    this.iconData,
    this.backButton,
    this.backIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (backButton != null && backIcon != null)
          Row(
            children: [
              GestureDetector(
                onTap: backButton,
                child: Icon(
                  backIcon,
                  color: Palette.greyColor,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                appBarTitle,
                style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  color: Palette.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        if (backButton == null && backIcon == null)
          Row(
            children: [
              Text(
                appBarTitle,
                style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  color: Palette.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        if (onTap != null && iconData != null)
          GestureDetector(
            onTap: onTap,
            child: Icon(
              iconData,
              color: Palette.greyColor,
            ),
          ),
      ],
    );
  }
}
