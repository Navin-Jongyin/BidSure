import 'dart:convert';
import 'package:bidsure_2/authentocation%20screen/login_Page.dart';
import 'package:bidsure_2/components/my_TextField.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  Future<void> createUser(
    String name,
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    String apiUrl = 'https://bidsure-backend.onrender.com/auth/signup';
    final Map<String, dynamic> userData = {
      'fullname': name,
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData));
    if (response.statusCode == 201) {
      print(response.body);
    } else if (response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      final existedUsername = jsonData['message'];
      if (existedUsername == 'username must be unique') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "User name already existed",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Palette.redColor,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Palette.redColor,
                    ),
                    child: Center(
                      child: Text(
                        "OK",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Palette.whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else if (existedUsername == 'email must be unique') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Email already existed",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Palette.redColor,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Palette.redColor,
                    ),
                    child: Center(
                      child: Text(
                        "OK",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Palette.whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } else {
      print("failed");
      print(response.body);
      print(passwordController.text);
      print(emailController.text);
    }
  }

  bool isEmailValid(String email) {
    // Regular expression for basic email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

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
                      onTap: () {
                        if (nameController.text.isEmpty ||
                            userNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "All field must be fill",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.redColor,
                                    ),
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: Navigator.of(context).pop,
                                      child: Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Palette.redColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "OK",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Palette.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else if (isEmailValid(emailController.text) ==
                            false) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Invalid Email Address",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.redColor,
                                  ),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: Navigator.of(context).pop,
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Palette.redColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Palette.whiteColor),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Password do not match",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.redColor,
                                  ),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: Navigator.of(context).pop,
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Palette.redColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Palette.whiteColor),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          createUser(
                            nameController.text,
                            userNameController.text,
                            emailController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Sign Up Success!",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.blueColor,
                                  ),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const LogInPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Palette.blueColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Log In",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Palette.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
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
                const SizedBox(
                  height: 20,
                ),
                Row(
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
                      width: 5,
                    ),
                    GestureDetector(
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Palette.blueColor),
                      ),
                    ),
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
