import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final Color? iconColor;
  final void Function()? onTap;

  const MyListTile({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Palette.whiteColor,
          leading: ImageIcon(
            AssetImage(
              imagePath,
            ),
            color: color,
          ),
          title: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Palette.greyColor,
            size: 18,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
