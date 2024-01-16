import 'package:bidsure_project/config/palette.dart';
import 'package:flutter/material.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({super.key});

  @override
  State<CreateAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Palette.darkMainColor,
    );
  }
}
