import 'package:amharic_ocr/bottom_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BottomNavScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: Image.asset("assets/splash.gif"),
          ),
          const SizedBox(height: 10),
          const Text(
            "ዲጂታል ምስሎች ወደ ጽሑፍ",
            style: TextStyle(fontSize: 18, fontFamily: "Nokia"),
          )
        ],
      )),
    );
  }
}
