import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class HlsVideoPlayer extends StatefulWidget {
  @override
  _HlsVideoPlayerState createState() => _HlsVideoPlayerState();
}

class _HlsVideoPlayerState extends State<HlsVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    final String videoUrl = 'http://192.168.1.39:8000/live/test/index.m3u8';

    try {
      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: _controller != null && _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: 9.0 / 16.0,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Palette.whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Palette.blueColor,
                        decoration: InputDecoration(
                          hintText: "Comments",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Palette.greyColor,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.blueColor,
                            ),
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
                        size: 30,
                        color: Palette.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: MediaQuery.of(context).size.height * .1,
              child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.blueColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          spreadRadius: 2,
                          blurRadius: 3,
                          color: Palette.greyColor)
                    ]),
                child: const Center(
                  child: ImageIcon(
                    AssetImage("icons/bidlogo.png"),
                    size: 40,
                    color: Palette.whiteColor,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 17,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Palette.whiteColor.withOpacity(0.8),
                    border: Border.all(color: Palette.greenColor)),
                child: Column(
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
                        Text(
                          "BidSure User2",
                          style: GoogleFonts.montserrat(
                              fontSize: 13, fontWeight: FontWeight.w500),
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
              top: 15,
              right: 10,
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Palette.blueColor],
                  ),
                ),
                child: Center(
                  child: Text(
                    "00:00:00",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
