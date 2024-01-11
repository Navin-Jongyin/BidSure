import 'package:bidsure_project/config/palette.dart';
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
      backgroundColor: Palette.darkMainColor,
      currentIndex: currentIndex,
      selectedItemColor: Palette.redMainColor,
      unselectedItemColor: Palette.whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme:
          const IconThemeData(color: Palette.redMainColor, size: 30),
      unselectedIconTheme:
          const IconThemeData(color: Palette.whiteColor, size: 30),
      selectedLabelStyle:
          GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/home.png"),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/explore_icon.png"),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/addition.png"),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/wallet.png"),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("icons/user.png"),
            ),
            label: ''),
      ],
    );
  }
}
