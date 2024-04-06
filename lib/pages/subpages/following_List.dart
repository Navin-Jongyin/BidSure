import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:flutter/material.dart';

class MyFollowing extends StatefulWidget {
  const MyFollowing({super.key});

  @override
  State<MyFollowing> createState() => _MyFollowingState();
}

class _MyFollowingState extends State<MyFollowing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Following",
          backIcon: Icons.arrow_back,
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
