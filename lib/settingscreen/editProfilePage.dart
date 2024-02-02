import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/settingscreen/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              "Edit Profile",
              style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  color: Palette.redMainColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            child: Container(
              margin: EdgeInsets.all(25),
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Palette.darkMainColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
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
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Surname",
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
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
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
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Bio",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Palette.darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),

                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 50 , horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
