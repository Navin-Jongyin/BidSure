import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/subpages/my_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  TextEditingController cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Add New Card",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MyCard(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cardNumberController,
                          cursorColor: Palette.blueColor,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberInputFormatter()
                          ],
                          decoration: InputDecoration(
                            hintText: "Card Number",
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 12, color: Palette.greyColor),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10),
                              child: ImageIcon(
                                AssetImage("icons/card.png"),
                                color: Palette.greyColor,
                              ),
                            ),
                            focusColor: Palette.blueColor,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.blueColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                cursorColor: Palette.blueColor,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.greyColor,
                                      ),
                                    ),
                                    hintText: "Exp Date (MM/YY)",
                                    hintStyle:
                                        GoogleFonts.montserrat(fontSize: 10),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage("icons/expiry.png"),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.blueColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                obscureText: true,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorColor: Palette.blueColor,
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.greyColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.blueColor,
                                    ),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ImageIcon(
                                      AssetImage("icons/cvc.png"),
                                    ),
                                  ),
                                  counterText: "",
                                  hintText: "CVV",
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 12, color: Palette.greyColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Palette.blueColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.greyColor),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Palette.blueColor,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              size: 30,
                            ),
                            hintText: "Name on card",
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 12, color: Palette.greyColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue.shade300,
                      Palette.blueColor,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Add Card",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }

    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}
