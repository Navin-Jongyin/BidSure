import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MsgWidget extends StatelessWidget {
  final String username;
  final String msg;
  const MsgWidget({super.key, required this.username, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 60),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.blueColor),
                ),
                Text(
                  msg,
                  style: TextStyle(
                      // color: Colors.yellow,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
