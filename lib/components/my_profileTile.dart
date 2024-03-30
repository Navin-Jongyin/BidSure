import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileListTile extends StatelessWidget {
  final String title;
  final Color color;
  final void Function()? onTap;

  const MyProfileListTile({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Palette.whiteColor,
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
    );
  }
}
