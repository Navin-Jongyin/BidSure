import 'package:bidsure_2/authentocation%20screen/login_Page.dart';
import 'package:bidsure_2/components/my_TextField.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.montserrat(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Join us to make a bid!",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  hintText: "Full Name",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.person_outline),
                  showSuffix: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: userNameController,
                    hintText: "Username",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.person_outline),
                    showSuffix: false,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.email_outlined),
                  showSuffix: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  showSuffix: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  hintText: "Confirm Password",
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  showSuffix: false,
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 60,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue.shade300, Palette.blueColor])),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SIGN UP",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.whiteColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Palette.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Palette.greyColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LogInPage(),
                    ),
                  );
                },
                child: Text(
                  "Sign In",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Palette.blueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
