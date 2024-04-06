import 'package:bidsure_2/camera/params.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class LiveAuction extends StatefulWidget {
  const LiveAuction({super.key});

  @override
  State<LiveAuction> createState() => _LiveAuctionState();
}

class _LiveAuctionState extends State<LiveAuction> {
  final TextEditingController priceController = TextEditingController();
  Params config = Params();
  late final ApiVideoLiveStreamController _controller;
  bool _isStreaming = false;

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

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    _controller = createLiveStreamController();

    _controller.initialize().catchError((e) {
      showInSnackBar(e.toString());
    });
    super.initState();
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
      },
    );
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

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.all(20),
            child: ApiVideoCameraPreview(
              controller: _controller,
            ),
          ),
          // Positioned(
          //   top: MediaQuery.of(context).size.height * 0.70,
          //   right: 25,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         height: 30,
          //         width: 70,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Palette.blueColor,
          //         ),
          //         child: Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 "+ 500",
          //                 style: GoogleFonts.montserrat(
          //                     fontSize: 16,
          //                     color: Palette.whiteColor,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return Theme(
          //                 data: ThemeData.dark(),
          //                 child: CupertinoAlertDialog(
          //                   title: const Text(
          //                     "Enter Price",
          //                     style: TextStyle(
          //                         fontSize: 18, fontFamily: '.SF Pro Text'),
          //                   ),
          //                   content: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       const Text(
          //                         "Enter Price to Bid. Once press confirm the process cannot be undo",
          //                         style: TextStyle(
          //                             fontSize: 13, fontFamily: '.SF Pro Text'),
          //                       ),
          //                       const SizedBox(
          //                         height: 10,
          //                       ),
          //                       CupertinoTextField(
          //                         style: const TextStyle(
          //                             color: Palette.whiteColor),
          //                         controller: priceController,
          //                         placeholder: "Enter Price",
          //                         keyboardType: TextInputType.number,
          //                       ),
          //                     ],
          //                   ),
          //                   actions: <Widget>[
          //                     CupertinoDialogAction(
          //                       child: const Text(
          //                         "Cancel",
          //                         style: TextStyle(
          //                             color: Palette.blueColor,
          //                             fontWeight: FontWeight.w600),
          //                       ),
          //                       onPressed: () {
          //                         Navigator.of(context).pop();
          //                       },
          //                     ),
          //                     CupertinoDialogAction(
          //                       child: const Text(
          //                         "Place Bid",
          //                         style: TextStyle(
          //                             color: Palette.blueColor,
          //                             fontWeight: FontWeight.w600),
          //                       ),
          //                       onPressed: () {
          //                         print("Place Bid");
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           );
          //         },
          //         child: Container(
          //           width: 70.0,
          //           height: 70.0,
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Palette.blueColor, // Adjust color as needed
          //             boxShadow: [
          //               BoxShadow(
          //                   offset: Offset(0, 3),
          //                   spreadRadius: 1,
          //                   blurRadius: 3,
          //                   color: Palette.greyColor)
          //             ],
          //           ),
          //           child: const Center(
          //             child: ImageIcon(
          //               AssetImage("icons/bidlogo.png"),
          //               size: 30,
          //               color: Palette.whiteColor,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _controller != null ? onSwitchCameraButtonPressed() : null;
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.yellowColor,
                ),
                child: const Icon(
                  Icons.cameraswitch,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.025,
            left: 25,
            right: 25,
            child: GestureDetector(
              onTap: () {
                _controller != null && _isStreaming
                    ? onStopStreamingButtonPressed()
                    : null;
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Palette.redColor,
                ),
                child: Center(
                  child: Text(
                    "End Live",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .05,
            right: 25,
            child: SafeArea(
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.darkBlueColor,
                ),
                child: Center(
                  child: Text(
                    "01:02:31",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Palette.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .05,
            left: 25,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.greyColor.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.redColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("User 1")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 22,
                          child: Image.asset(
                            "icons/baht.png",
                            color: Palette.greenColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "1,200",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Palette.greenColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //     top: MediaQuery.sizeOf(context).height * 0.01,
          //     left: 25,
          //     child: SafeArea(
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).pushReplacement(
          //             PageRouteBuilder(
          //               pageBuilder: (context, animation, secondaryAnimation) =>
          //                   const HomePage(),
          //             ),
          //           );
          //           ;
          //         },
          //         child: Container(
          //           height: 35,
          //           width: 35,
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Palette.redColor,
          //           ),
          //           child: const Center(
          //             child: Icon(
          //               Icons.close,
          //               color: Palette.whiteColor,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ))
        ],
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
