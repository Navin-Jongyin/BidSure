import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/settings/editProfile_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBio extends StatefulWidget {
  const EditBio({super.key});

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
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
                  "Bio",
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
          child: TextField(
            controller: _nameController,
            maxLines: 5,
            minLines: 5,
            maxLength: 80,
            cursorColor: Palette.blueColor,
            decoration: InputDecoration(
              counterStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Palette.greyColor),
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
              hintText: "Add a Bio",
              hintStyle: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Palette.greyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
