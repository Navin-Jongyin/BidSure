import 'package:bidsure_2/components/borderless_Textfield.dart';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/subpages/shipping_Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyAppBar(
          appBarTitle: "Add New Address",
          backButton: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ShippingAddress(),
              ),
            );
          },
          backIcon: Icons.arrow_back,
        ),
      ),
      body: Stack(
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BorderlessTextField(
                    labelText: "Name",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BorderlessTextField(
                    labelText: "Phone Number",
                    keyboardType: TextInputType.phone, // Changed to phone
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BorderlessTextField(
                    labelText: "Address Details",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BorderlessTextField(
                          labelText: "District",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BorderlessTextField(
                          labelText: "Sub-District",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BorderlessTextField(
                          labelText: "Province",
                          keyboardType:
                              TextInputType.text, // Removed unnecessary options
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: BorderlessTextField(
                        labelText: "Zip Code",
                        keyboardType: TextInputType.text,
                      ))
                    ],
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
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                    )),
                child: Center(
                  child: Text(
                    "Save",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Palette.whiteColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
