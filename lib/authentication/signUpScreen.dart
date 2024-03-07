import 'package:bidsure_project/authentication/createProfileScreen.dart';
import 'package:bidsure_project/authentication/loginScreen.dart';
import 'package:bidsure_project/components/myButton.dart';
import 'package:bidsure_project/components/myTextField.dart';
import 'package:bidsure_project/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset("images/BidSure_Logo.png"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create your account",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Palette.darkMainColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: emailController,
                  labelText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  labelText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyButton(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const CreateProfile(),
                      ),
                    );
                  },
                  text: "Continue",
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.darkMainColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LogInPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Palette.redMainColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
