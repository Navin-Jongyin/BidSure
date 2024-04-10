import 'dart:convert';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:bidsure_2/camera/constants.dart';
import 'package:bidsure_2/camera/params.dart';
import 'package:bidsure_2/camera/settings_screen.dart';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/model/live_msg_model.dart';
import 'package:bidsure_2/model/msg_widget.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveViewPage extends StatefulWidget {
  const LiveViewPage({Key? key}) : super(key: key);

  @override
  _LiveViewPageState createState() => new _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage>
    with WidgetsBindingObserver {
  Params config = Params();
  late final ApiVideoLiveStreamController _controller;
  bool _isStreaming = false;
  String rtmpUrl = '';
  int? auctionId;
  int socketUserId = 0;
  String socketUsername = "";
  IO.Socket? socket;
  List<LiveMsgModel> listMsg = [];
  TextEditingController _liveMsgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getOneAuction();
    WidgetsBinding.instance.addObserver(this);

    _controller = createLiveStreamController();

    _controller.initialize().catchError((e) {
      showInSnackBar(e.toString());
    });
    connect();
    getUserSocket();
  }

  Future<void> getUserSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/user/getusersocket';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final id = jsonData['userId'];
        final username = jsonData['username'];
        setState(() {
          socketUsername = username;
          socketUserId = id;
          print(socketUserId);
          print(socketUsername);
        });
      }
    }
  }

  Future<void> deleteAuction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl =
          'https://bidsure-backend.onrender.com/auction/deleteauction';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'auctionId': auctionId}),
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    }
  }

  Future<void> getOneAuction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl =
          'https://bidsure-backend.onrender.com/auction/getliveauctioninfo';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        final jsonData = data['info'];

        var auctionid = jsonData['id'];

        setState(() {
          auctionId = auctionid;
          print("Auction ID $auctionId");
        });
      }
    }
  }

  void connect() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print("frontend connected");
      socket!.on("sendMsgServer", (msg) {
        print("Received message: $msg");
        try {
          if (msg != null && msg is Map<String, dynamic>) {
            final int id = msg['id'];
            final String? username = msg['username'];
            final String? receivedMsg = msg['msg'];
            if (username != null &&
                receivedMsg != null &&
                msg["userId"] != socketUserId &&
                msg["id"] == auctionId) {
              setState(() {
                listMsg.add(LiveMsgModel(
                  id: id,
                  msg: receivedMsg,
                  username: username,
                ));
              });
            } else {
              print(
                  "One of the properties is null: , sender=$username, receivedMsg=$receivedMsg");
            }
          } else {
            print("Invalid message format: $msg");
          }
        } catch (e, stackTrace) {
          print("Error processing message: $e");
          print(stackTrace);
        }
      });
    });
  }

  void sendMsg(int id, String msg, String userName) {
    LiveMsgModel ownMsg = LiveMsgModel(id: id, msg: msg, username: userName);
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      "id": id,
      "msg": msg,
      "username": userName,
      "userId": socketUserId,
    });
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "BidSure",
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
        child: Stack(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Center(
                          child: ApiVideoCameraPreview(controller: _controller),
                        ),
                      ),
                    ),
                  ),
                  _controlRowWidget(),
                ],
              ),
            ),
            Positioned(
              left: 20,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Palette.whiteColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Palette.greenColor,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Palette.redColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "BidSure User1",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Palette.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage("icons/baht.png"),
                          color: Palette.greenColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "0,000",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Palette.greenColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 110,
              child: Container(
                width: 200,
                height: 300,
                child: ListView.builder(
                  reverse: true, // Reverse the order of children
                  itemCount: listMsg.length > 4
                      ? 4
                      : listMsg.length, // Show maximum 4 messages
                  itemBuilder: (context, index) {
                    final int reversedIndex = listMsg.length - 1 - index;
                    return MsgWidget(
                      msg: listMsg[reversedIndex].msg,
                      username: listMsg[reversedIndex].username,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Palette.backgroundColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _liveMsgController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Palette.greyColor,
                        ),
                        cursorColor: Palette.blueColor,
                        decoration: InputDecoration(
                          hintText: "Comments",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Palette.greyColor,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.greyColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.send,
                        color: Palette.blueColor,
                        size: 30,
                      ),
                      onTap: () {
                        String msg = _liveMsgController.text;
                        if (msg.isNotEmpty) {
                          sendMsg(auctionId!, _liveMsgController.text,
                              socketUsername);
                          _liveMsgController.clear();
                          print(listMsg);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMenuSelected(String choice, BuildContext context) {
    if (choice == Constants.Settings) {
      _awaitResultFromSettingsFinal(context);
    }
  }

  void _awaitResultFromSettingsFinal(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsScreen(params: config)));
    _controller.setVideoConfig(config.video);
    _controller.setAudioConfig(config.audio);
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _controlRowWidget() {
    final ApiVideoLiveStreamController? liveStreamController = _controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.cameraswitch),
          color: Palette.blueColor,
          onPressed:
              liveStreamController != null ? onSwitchCameraButtonPressed : null,
        ),
        GestureDetector(
          child: Text(
            "Start Live",
            style: GoogleFonts.montserrat(
                fontSize: 14,
                color: _isStreaming ? Palette.greyColor : Palette.redColor,
                fontWeight: FontWeight.bold),
          ),
          onTap: liveStreamController != null && !_isStreaming
              ? onStartStreamingButtonPressed
              : null,
        ),
        GestureDetector(
          child: Text(
            "End Live",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: _isStreaming ? Palette.redColor : Palette.greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: liveStreamController != null && _isStreaming
              ? onStopStreamingButtonPressed
              : null,
        )
      ],
    );
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
    print(config.streamKey);

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
    getOneAuction();
    getUserSocket();
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
    deleteAuction();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
      ),
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
