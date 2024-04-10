import 'dart:convert';

import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> changePassword() async {
    String current = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmNewPasswordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New password does not match',
            style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Palette.redColor,
                fontWeight: FontWeight.w500),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    const apiUrl = "https://bidsure-backend.onrender.com/user/changepassword";
    final response = await http.patch(
      Uri.parse(apiUrl),
      body: json.encode({
        'currentPassword': current,
        'newPassword': newPassword,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData.dark(),
              child: CupertinoAlertDialog(
                title: Text("Sucessfu;"),
                content: Text("Change password succesfully"),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "Done",
                      style: TextStyle(color: Palette.blueColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The Current Password is not correct',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Palette.redColor,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
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
                      changePassword();
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
