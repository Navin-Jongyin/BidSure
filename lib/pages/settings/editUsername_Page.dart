import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/settings/editProfile_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUsername extends StatefulWidget {
  const EditUsername({super.key});

  @override
  State<EditUsername> createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateSaveButtonState);
    _nameController.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    setState(() {
      _isSaveButtonEnabled = _nameController.text.isNotEmpty;
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
                            const EditProfile(),
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
                  "Username",
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
                controller: _nameController,
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
                  hintText: "Username",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Username can contain only letters, numbers, underscors, and periods.",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Palette.redColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
