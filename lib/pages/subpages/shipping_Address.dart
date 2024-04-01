import 'package:bidsure_2/components/my_AddressTile.dart';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/subpages/addShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Shipping Address",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
          iconData: Icons.add,
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddShippingAddress(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyAddressTile(
              name: "Navin Jongyin",
              addressDetail: "Bangkok Thailand",
              phoneNumber: "0812345678",
            ),
          ],
        ),
      ),
    );
  }
}
