import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bidsure_2/authentocation%20screen/login_Page.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue.shade100,
          cursorColor: Palette.redColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 2000,
        splash: 'images/splashlogo.png',
        backgroundColor: Palette.greyColor,
        nextScreen: const LogInPage(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 120,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
