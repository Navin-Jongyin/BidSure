import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_profileTile.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/main.dart';
import 'package:bidsure_2/pages/settings/editBio_Page.dart';
import 'package:bidsure_2/pages/settings/editUsername_Page.dart';
import 'package:bidsure_2/pages/settings/editname_Page.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Edit Profile",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SettingsPage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Palette.darkBlueColor,
                        ),
                      ),
                      Positioned(
                        top: 85,
                        left: 85,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Palette.blueColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 20,
                                  color: Palette.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Text(
                    "User Information",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                MyProfileListTile(
                  title: "Name",
                  color: Palette.greyColor,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const EditName(),
                      ),
                    );
                  },
                ),
                MyProfileListTile(
                  title: "Bio",
                  color: Palette.greyColor,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const EditBio(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Text(
                    "Social Media",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyProfileListTile(
                  title: "Instagram",
                  color: Palette.greyColor,
                  onTap: () {},
                ),
                MyProfileListTile(
                  title: "Facebook",
                  color: Palette.greyColor,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
