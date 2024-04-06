import 'dart:io';
import 'dart:ui';

import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/bidderOnlineAuction.dart';
import 'package:bidsure_2/pages/auctionPages/onlineAuction.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOnlineAuction extends StatefulWidget {
  const NewOnlineAuction({super.key});

  @override
  State<NewOnlineAuction> createState() => _NewOnlineAuctionState();
}

class _NewOnlineAuctionState extends State<NewOnlineAuction> {
  final List<int> times = List.generate(6, (index) => index + 1);
  int selectedTime = 0;
  TextEditingController itemName = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  TextEditingController startPrice = TextEditingController();
  TextEditingController minimumBid = TextEditingController();
  File? _image;

  Future<void> selectAndUploadImage() async {
    File? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      uploadImageToApi(image);
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

  Future<void> createAuction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = "http://192.168.1.39:3000/auction/";
      final response = await http.post(Uri.parse(apiUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "New Online Auction",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: TextField(
                    maxLength: 24,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkGreyColor),
                    cursorHeight: 20,
                    cursorColor: Palette.blueColor,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.greyColor,
                        ),
                      ),
                      labelText: "Item Name",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.blueColor),
                      ),
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      focusColor: Palette.blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: TextField(
                    maxLength: 80,
                    minLines: 5,
                    maxLines: 5,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkGreyColor),
                    cursorHeight: 20,
                    cursorColor: Palette.blueColor,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.greyColor,
                        ),
                      ),
                      labelText: "Item Description",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.blueColor),
                      ),
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                      focusColor: Palette.blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Palette.darkGreyColor),
                          cursorHeight: 20,
                          cursorColor: Palette.blueColor,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Start Price",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                            floatingLabelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            focusColor: Palette.blueColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Palette.darkGreyColor),
                          cursorHeight: 20,
                          cursorColor: Palette.blueColor,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Minimum Bid",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                            floatingLabelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                            focusColor: Palette.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Add Item Images",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    selectAndUploadImage();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.greyColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Palette.greyColor,
                      ),
                    ),
                  ),
                ),
                // FloatingActionButton(onPressed: () {
                //   Navigator.of(context).pushReplacement(
                //     PageRouteBuilder(
                //       pageBuilder: (context, animation, secondaryAnimation) =>
                //           const UserOnlineAuction(),
                //     ),
                //   );
                // })
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(25),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Theme(
                  data: ThemeData.dark(),
                  child: CupertinoAlertDialog(
                    title: const Text(
                      "Select Auction Duration",
                      style:
                          TextStyle(fontSize: 18, fontFamily: '.SF Pro Text'),
                    ),
                    content: SizedBox(
                      height: 100, // Set a fixed height for the container
                      child: ListWheelScrollView(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 40,
                        diameterRatio: 0.7, // Height of each item
                        children: times.map((int time) {
                          return Center(
                            child: Text(
                              '$time Hours',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedTime = times[index];
                          });
                        },
                      ),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Palette.blueColor,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text(
                          "Select",
                          style: TextStyle(
                            color: Palette.blueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          print(selectedTime);
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const OnlineAuction(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Palette.blueColor],
              ),
            ),
            child: Center(
              child: Text(
                "Continue",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
