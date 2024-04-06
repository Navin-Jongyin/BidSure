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
  File? _image;
  String aucmode = "online";
  String aucendtime = "2";

  Future<void> createAuction(String itemName, String itemDes, String startPrice,
      String minBid, String mode, File imageFile, String endtime) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var apiUrl = Uri.parse('http://192.168.1.39:3000/auction/');
      var request = http.MultipartRequest('POST', apiUrl);

      // Add text fields to the request
      request.fields['name'] = itemName;
      request.fields['description'] = itemDes;
      request.fields['startingPrice'] = startPrice;
      request.fields['minBid'] = minBid;
      request.fields['mode'] = mode;
      request.fields['endTime'] = endtime;

      // Add image file to the request
      var imageField =
          await http.MultipartFile.fromPath('auctionImages', imageFile.path);
      request.files.add(imageField);

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

  // Future<void> selectAndUploadImage() async {
  //   File? image = await pickImage(ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _image = image;
  //     });
  //     uploadImageToApi(image);
  //   }
  // }

  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Future<void> uploadImageToApi(File imageFile) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('token');
  //     if (token != null) {
  //       String apiUrl = "http://192.168.1.39:3000/user/updateimage";
  //       var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));

  //       request.files.add(
  //           await http.MultipartFile.fromPath('userImage', imageFile.path));
  //       request.headers['Authorization'] = 'Bearer $token';
  //       request.headers['Content-Type'] = 'multipart/form-data';

  //       var streamedResponse = await request.send();

  //       var response = await http.Response.fromStream(streamedResponse);

  //       if (response.statusCode == 200) {
  //         print("Image Uploaded Success");
  //         print(response.body);
  //       } else {
  //         print('Failed to upload image. Status code: ${response.statusCode}');
  //         print(response.body);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  late final ApiVideoLiveStreamController _controller;
  bool _isStreaming = false;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    _controller = createLiveStreamController();

    _controller.initialize().catchError((e) {
      showInSnackBar(e.toString());
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (!_controller.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.startPreview();
    }
  }

  Future<void> switchCamera() async {
    final ApiVideoLiveStreamController? liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('Error: create a camera controller first.');
      return;
    }

    return await liveStreamController.switchCamera();
  }

  Future<void> toggleMicrophone() async {
    final ApiVideoLiveStreamController? liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('Error: create a camera controller first.');
      return;
    }

    return await liveStreamController.toggleMute();
  }

  Future<void> startStreaming() async {
    final ApiVideoLiveStreamController? controller = _controller;

    if (controller == null) {
      print('Error: create a camera controller first.');
      return;
    }

    return await controller.startStreaming(
        streamKey: config.streamKey, url: config.rtmpUrl);
  }

  Future<void> stopStreaming() async {
    final ApiVideoLiveStreamController? controller = _controller;

    if (controller == null) {
      print('Error: create a camera controller first.');
      return;
    }

    return await controller.stopStreaming();
  }

  void onSwitchCameraButtonPressed() {
    switchCamera().then((_) {
      if (mounted) {
        setState(() {});
      }
    }).catchError((error) {
      if (error is PlatformException) {
        _showDialog(
            context, "Error", "Failed to switch camera: ${error.message}");
      } else {
        _showDialog(context, "Error", "Failed to switch camera: $error");
      }
    });
  }

  void onToggleMicrophoneButtonPressed() {
    toggleMicrophone().then((_) {
      if (mounted) {
        setState(() {});
      }
    }).catchError((error) {
      if (error is PlatformException) {
        _showDialog(
            context, "Error", "Failed to toggle mute: ${error.message}");
      } else {
        _showDialog(context, "Error", "Failed to toggle mute: $error");
      }
    });
  }

  void onStartStreamingButtonPressed() {
    startStreaming().then((_) {
      if (mounted) {
        setIsStreaming(true);
      }
    }).catchError((error) {
      if (error is PlatformException) {
        _showDialog(
            context, "Error", "Failed to start stream: ${error.message}");
      } else {
        _showDialog(context, "Error", "Failed to start stream: $error");
      }
    });
  }

  void onStopStreamingButtonPressed() {
    stopStreaming().then((_) {
      if (mounted) {
        setIsStreaming(false);
      }
    }).catchError((error) {
      if (error is PlatformException) {
        _showDialog(
            context, "Error", "Failed to stop stream: ${error.message}");
      } else {
        _showDialog(context, "Error", "Failed to stop stream: $error");
      }
    });
  }

  void setIsStreaming(bool isStreaming) {
    setState(() {
      if (isStreaming) {
        WakelockPlus.enable();
      } else {
        WakelockPlus.disable();
      }
      _isStreaming = isStreaming;
    });
  }

  ApiVideoLiveStreamController createLiveStreamController() {
    return ApiVideoLiveStreamController(
        initialAudioConfig: config.audio,
        initialVideoConfig: config.video,
        onConnectionSuccess: () {
          print('Connection succeeded');
        },
        onConnectionFailed: (error) {
          print('Connection failed: $error');
          _showDialog(context, 'Connection failed', '$error');
          if (mounted) {
            setIsStreaming(false);
          }
        },
        onDisconnection: () {
          showInSnackBar('Disconnected');
          if (mounted) {
            setIsStreaming(false);
          }
        },
        onError: (error) {
          // Get error such as missing permission,...
          _showDialog(context, 'Error', '$error');
          if (mounted) {
            setIsStreaming(false);
          }
        });
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: TextField(
                      controller: itemNameController,
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
                      controller: itemDescription,
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
                            controller: startPrice,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.blueColor),
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
                            controller: minimumBid,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.blueColor),
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
                    onTap: () async {
                      File? image = await pickImage(ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _image = image;
                        });
                      }
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                  // FloatingActionButton(onPressed: () {
                  //   Navigator.of(context).pushReplacement(
                  //     PageRouteBuilder(
                  //       pageBuilder: (context, animation, secondaryAnimation) =>
                  //           HlsVideoPlayer(),
                  //     ),
                  //   );
                  // })
                ],
              ),
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
            print("onTap");
            createAuction(itemNameController.text, itemDescription.text,
                startPrice.text, minimumBid.text, aucmode, _image!, aucendtime);
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return Theme(
            //       data: ThemeData.dark(),
            //       child: CupertinoAlertDialog(
            //         title: const Text(
            //           "Select Auction Duration",
            //           style:
            //               TextStyle(fontSize: 18, fontFamily: '.SF Pro Text'),
            //         ),
            //         content: SizedBox(
            //           height: 100, // Set a fixed height for the container
            //           child: ListWheelScrollView(
            //             physics: const FixedExtentScrollPhysics(),
            //             itemExtent: 40,
            //             diameterRatio: 0.7, // Height of each item
            //             children: times.map((int time) {
            //               return Center(
            //                 child: Text(
            //                   '$time Hours',
            //                   style: const TextStyle(
            //                     fontSize: 18.0,
            //                   ),
            //                 ),
            //               );
            //             }).toList(),
            //             onSelectedItemChanged: (int index) {
            //               setState(() {
            //                 selectedTime = times[index];
            //               });
            //             },
            //           ),
            //         ),
            //         actions: <Widget>[
            //           CupertinoDialogAction(
            //             child: const Text(
            //               "Cancel",
            //               style: TextStyle(
            //                   color: Palette.blueColor,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //             },
            //           ),
            //           CupertinoDialogAction(
            //             child: const Text(
            //               "Select",
            //               style: TextStyle(
            //                 color: Palette.blueColor,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //             onPressed: () {
            //               // print(selectedTime);
            //               // onStartStreamingButtonPressed();
            //               Navigator.of(context).pushReplacement(
            //                 PageRouteBuilder(
            //                   pageBuilder:
            //                       (context, animation, secondaryAnimation) =>
            //                           const LiveViewPage(),
            //                 ),
            //               );
            //             },
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // );
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
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

Future<void> _showDialog(
    BuildContext context, String title, String description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(description),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
