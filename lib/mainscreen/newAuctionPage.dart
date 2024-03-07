import 'package:bidsure_project/components/myButton.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino package
import 'package:google_fonts/google_fonts.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({Key? key}) : super(key: key);

  @override
  State<CreateAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  String bidIncrease = '';
  bool switchValue = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Palette.darkMainColor,
              ),
            ),
            Text(
              "Create New Auction",
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                color: Palette.redMainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Item Name",
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Palette.redMainColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                minLines: 5,
                maxLines: 10,
                maxLength: 250,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Item Description",
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Palette.redMainColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Price",
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Palette.redMainColor,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(Icons.currency_bitcoin),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.startsWith('0')) {
                          if (value.length > 1 && value.length != 0) {
                            setState(() {
                              bidIncrease = value.replaceAll(RegExp('^0+'), '');
                            });
                          }
                        } else {
                          bidIncrease = value;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Bid Increase",
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Palette.redMainColor,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(Icons.currency_bitcoin),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Date",
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              switchValue ? Colors.grey : Palette.redMainColor,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      enabled: !switchValue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.startsWith('0')) {
                          if (value.length > 1 && value.length != 0) {
                            setState(() {
                              bidIncrease = value.replaceAll(RegExp('^0+'), '');
                            });
                          }
                        } else {
                          bidIncrease = value;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Time",
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: switchValue
                              ? Colors.grey
                              : Palette
                                  .redMainColor, // Change color to grey when switch is on
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      enabled:
                          !switchValue, // Disable text field when switch is on
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Live Stream Auction",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkMainColor),
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Add Item Image",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Palette.redMainColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("tap");
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey.shade400,
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyButton(
        onTap: () {},
        text: "Start Auction",
      ),
    );
  }
}
