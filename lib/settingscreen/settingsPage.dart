import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/profilePage.dart';
import 'package:bidsure_project/settingscreen/changePasswordPage.dart';
import 'package:bidsure_project/settingscreen/editProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                        const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Palette.darkMainColor,
                size: 25,
              ),
            ),
            Text(
              "Settings",
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                color: Palette.redMainColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            buildListTile(
              "Edit Profile",
              Icons.person,
              Palette.darkMainColor,
              () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const EditProfilePage(),
                  ),
                );
              },
            ),
            buildListTile(
              "Change Password",
              Icons.edit,
              Palette.darkMainColor,
              () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChangePasswordPage(),
                  ),
                );
              },
            ),
            const Divider(
              color: Palette.greyColor,
            ),
            buildListTile("Delete Account", Icons.delete, Palette.redMainColor,
                showDeleteAccountDialog),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String title, IconData icon, Color textColor,
      VoidCallback onTapCallBack) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
      onTap: onTapCallBack,
      trailing: const Icon(
        Icons.arrow_forward_ios, // Right arrow icon
        color: Palette.greyColor,
      ),
    );
  }

  void showDeleteAccountDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete your account?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                // Handle delete account logic here
                // ...
                Navigator.pop(context); // Close the dialog
              },
              isDestructiveAction: true,
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
