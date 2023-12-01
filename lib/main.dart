import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:signify/screens/speechToSign.dart';
import 'package:signify/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/logo/sanket_icon.png',
        duration: 1000,
        nextScreen: const SplashScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.orange,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
