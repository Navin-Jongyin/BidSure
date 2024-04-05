import 'dart:convert';
import 'dart:io';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_profileTile.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/settings/editBio_Page.dart';
import 'package:bidsure_2/pages/settings/editname_Page.dart';
import 'package:bidsure_2/pages/settings/settings_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String fullname = '';
  File? _image;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> selectAndUploadImage() async {
    File? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      uploadImageToApi(image);
    }
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.39:3000/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'http://192.168.1.39:3000';
        final jsonData = jsonDecode(response.body);
        final name = jsonData['fullname'];
        final pic = jsonData['image'];
        imagePath = baseUrl + pic;
        print(name);
        print(pic);
        print(imagePath);

        setState(() {
          fullname = name;
          imagePath = imagePath;
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> uploadImageToApi(File imageFile) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        String apiUrl = "http://192.168.1.39:3000/user/updateimage";
        var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));

        request.files.add(
            await http.MultipartFile.fromPath('userImage', imageFile.path));
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'multipart/form-data';

        var streamedResponse = await request.send();

        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          print("Image Uploaded Success");
          print(response.body);
        } else {
          print('Failed to upload image. Status code: ${response.statusCode}');
          print(response.body);
        }
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

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
                      ClipOval(
                        child: imagePath.isNotEmpty
                            ? Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              )
                            : Image.asset(
                                "icons/avatar.png",
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                      ),
                      Positioned(
                        top: 85,
                        left: 85,
                        child: GestureDetector(
                          onTap: () {
                            selectAndUploadImage();
                          },
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
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    fullname,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.darkGreyColor,
                        fontWeight: FontWeight.w500),
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
