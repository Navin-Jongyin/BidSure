import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/settingscreen/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SettingsPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Palette.darkMainColor,
            ),
          ),
          Text(
            "Change Password",
            style: GoogleFonts.montserratAlternates(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.redMainColor,
            ),
          )
        ]),
      ),
    );
  }
}
