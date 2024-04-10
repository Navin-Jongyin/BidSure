import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WonItem extends StatefulWidget {
  const WonItem({Key? key}) : super(key: key);

  @override
  State<WonItem> createState() => _WonItemState();
}

class _WonItemState extends State<WonItem> {
  List<dynamic> buyers = [];
  List<dynamic> sellers = [];

  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  Future<void> getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'https://bidsure-backend.onrender.com/transection/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('buyer') &&
            responseData.containsKey('seller')) {
          setState(() {
            buyers = responseData['buyer'];
            sellers = responseData['seller'];
          });
        } else {
          print("Buyer or seller data not found in the response.");
        }
      } else {
        print("Failed to fetch transactions");
        print(response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Won Item",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buyers:'),
          Expanded(
            child: ListView.builder(
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                final buyer = buyers[index];
                return ListTile(
                  title: Text('Buyer ID: ${buyer['buyerId']}'),
                  subtitle: Text(
                      'Auction ID: ${buyer['auctionId']}, Price: ${buyer['price']}'),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Sellers:'),
          Expanded(
            child: ListView.builder(
              itemCount: sellers.length,
              itemBuilder: (context, index) {
                final seller = sellers[index];
                return ListTile(
                  title: Text('Seller ID: ${seller['sellerId']}'),
                  subtitle: Text(
                      'Auction ID: ${seller['auctionId']}, Price: ${seller['price']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
