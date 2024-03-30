import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  bool _isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    currentPasswordController.addListener(_updateSaveButtonState);
    newPasswordController.addListener(_updateSaveButtonState);
    confirmNewPasswordController.addListener(_updateSaveButtonState);
    _updateSaveButtonState(); // Call the method to initialize button state
  }

  @override
  void dispose() {
    currentPasswordController.removeListener(_updateSaveButtonState);
    currentPasswordController.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    setState(() {
      _isSaveButtonEnabled = currentPasswordController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty &&
          confirmNewPasswordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingsPage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Palette.greyColor,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Change Password",
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.blueColor,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _isSaveButtonEnabled
                  ? () {
                      print("Save Tap");
                    }
                  : null,
              child: Text(
                "Save",
                style: GoogleFonts.montserratAlternates(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _isSaveButtonEnabled
                      ? Palette.blueColor
                      : Palette.greyColor,
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                controller: currentPasswordController,
                cursorColor: Palette.blueColor,
                obscureText: true,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  hintText: "Current Password",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                cursorColor: Palette.blueColor,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  hintText: "New Password",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: confirmNewPasswordController,
                cursorColor: Palette.blueColor,
                obscureText: true,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Palette.greyColor,
                      width: 0.5,
                    ),
                  ),
                  hintText: "Confirm New Password",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
