import 'package:bidsure_2/authentocation%20screen/login_Page.dart';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_listTile.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/settings/change_Password.dart';
import 'package:bidsure_2/pages/settings/editProfile_Page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Settings",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              MyListTile(
                title: "Edit Profile",
                imagePath: "icons/user.png",
                color: Palette.greyColor,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const EditProfile(),
                    ),
                  );
                },
              ),
              MyListTile(
                title: "Change Password",
                imagePath: "icons/lock.png",
                color: Palette.greyColor,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ChangePassword(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              MyListTile(
                title: "Logout",
                imagePath: "icons/logout.png",
                color: Palette.redColor,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LogInPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
