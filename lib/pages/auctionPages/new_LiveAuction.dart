import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/auctionPages/bidderLiveAuction.dart';
import 'package:bidsure_2/pages/auctionPages/liveStreamAuction.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:bidsure_2/camera/params.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:path_provider/path_provider.dart';

class NewLiveAuction extends StatefulWidget {
  const NewLiveAuction({Key? key}) : super(key: key);

  @override
  State<NewLiveAuction> createState() => _NewLiveAuctionState();
}

class _NewLiveAuctionState extends State<NewLiveAuction> {
  final List<int> times = List.generate(3, (index) => index);
  int selectedTime = 0;
  Params config = Params();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  TextEditingController startPrice = TextEditingController();
  TextEditingController minimumBid = TextEditingController();
  String aucmode = "live";
  String endtime = "2";

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> _imageFileList = [];

  Future<void> createAuction(String itemName, String itemDes, String startPrice,
      String minBid, String mode, List<XFile> imageList, String endtime) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var apiUrl = Uri.parse('http://192.168.1.43:3000/auction/');
      var request = http.MultipartRequest('POST', apiUrl);

      // Add text fields to the request
      request.fields['name'] = itemName;
      request.fields['description'] = itemDes;
      request.fields['startingPrice'] = startPrice;
      request.fields['minBid'] = minBid;
      request.fields['mode'] = mode;
      request.fields['endTime'] = endtime;

      // Add image file to the request
      for (var i = 0; i < imageList.length; i++) {
        var imageField = await http.MultipartFile.fromPath(
            'auctionImages', imageList[i].path);
        request.files.add(imageField);
      }

      // Set authorization header
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Send the request
      var response = await request.send();

      // Get the response
      if (response.statusCode == 201) {
        print('Auction created successfully');
      } else {
        print('Failed to create auction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating auction: $e');
    }
  }

  void selectMultiImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFileList.addAll(selectedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "New Live Auction",
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
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: itemNameController,
                    cursorColor: Palette.blueColor,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLength: 24,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.greyColor,
                        ),
                      ),
                      labelText: "Item Name",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Palette.greyColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.blueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: itemDescription,
                  cursorColor: Palette.blueColor,
                  maxLines: 5,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLength: 80,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.greyColor,
                      ),
                    ),
                    labelText: "Item Description",
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Palette.greyColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palette.blueColor,
                      ),
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
                          controller: startPrice,
                          cursorColor: Palette.blueColor,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Starting Price",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Palette.greyColor,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.blueColor,
                              ),
                            ),
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
                          controller: minimumBid,
                          cursorColor: Palette.blueColor,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.greyColor,
                              ),
                            ),
                            labelText: "Minimum Bid",
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Palette.greyColor,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.blueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Item Images",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.greyColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    selectMultiImage();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Palette.darkGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _imageFileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          Image.file(
                            File(_imageFileList[index].path),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _imageFileList.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
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
                          style: TextStyle(
                              fontSize: 18, fontFamily: '.SF Pro Text'),
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
                              createAuction(
                                  itemNameController.text,
                                  itemDescription.text,
                                  startPrice.text,
                                  minimumBid.text,
                                  aucmode,
                                  _imageFileList,
                                  selectedTime.toString());
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const LiveViewPage(),
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
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Palette.blueColor],
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.whiteColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
