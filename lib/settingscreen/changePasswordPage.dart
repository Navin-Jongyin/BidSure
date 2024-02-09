import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/settingscreen/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool isCurrentPasswordValid = false;
  bool isNewPasswordValid = false;
  bool isConfirmNewPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
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
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 40, 20, 15),
            child: TextFormField(
              controller: currentPasswordController,
              onChanged: (value) {
                setState(() {
                  isCurrentPasswordValid = // Add your conditions for the current password
                      value.length >=
                          6; // For example, requiring a minimum length of 6 characters
                });
              },
              decoration: InputDecoration(
                labelText: "Current Password",
                errorText: isCurrentPasswordValid ? null : "Invalid password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Palette.darkMainColor,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: TextFormField(
              controller: newPasswordController,
              onChanged: (value) {
                setState(() {
                  isNewPasswordValid = // Add your conditions for the new password
                      value.length >=
                          6; // For example, requiring a minimum length of 6 characters
                });
              },
              decoration: InputDecoration(
                labelText: "New Password",
                errorText: isNewPasswordValid ? null : "Invalid password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Palette.darkMainColor,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              controller: confirmNewPasswordController,
              onChanged: (value) {
                setState(() {
                  isConfirmNewPasswordValid =
                      value == newPasswordController.text;
                });
              },
              decoration: InputDecoration(
                labelText: "Confirm New Password",
                errorText:
                    isConfirmNewPasswordValid ? null : "Passwords do not match",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Palette.darkMainColor,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        child: FloatingActionButton(
          backgroundColor: Palette.redMainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {},
          child: Text(
            "Save",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Palette.whiteColor),
          ),
        ),
      ),
    );
  }
}
