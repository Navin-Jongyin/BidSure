import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_cardModal.dart';
import 'package:bidsure_2/components/palette.dart';

import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/subpages/add_NewCard.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "My Card",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddNewCard(),
              ),
            );
          },
          iconData: Icons.add,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              MyCardList(
                  imagePath: "icons/visa.webp",
                  cardNumber: "4162 xxxx xxxx 7642",
                  expDate: "05/24")
            ],
          ),
        ),
      ),
    );
  }
}
