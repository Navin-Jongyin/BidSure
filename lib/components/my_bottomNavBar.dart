import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Palette.whiteColor,
      currentIndex: currentIndex,
      selectedItemColor: Palette.blueColor,
      unselectedItemColor: Palette.greyColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme:
          const IconThemeData(color: Palette.blueColor, size: 25),
      unselectedIconTheme:
          const IconThemeData(color: Palette.greyColor, size: 25),
      selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 14, color: Palette.blueColor, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/home.png"),
            ),
            label: "Home"),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("icons/explore_icon.png"),
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/addition.png"),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/wallet.png"),
            ),
            label: 'Wallet'),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/user.png"),
            ),
            label: 'Profile'),
      ],
    );
  }
}
