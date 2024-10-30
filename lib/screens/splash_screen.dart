import 'dart:developer';

import 'package:final_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../api/apis.dart';
import '../main.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //for auto triggering animation
    Future.delayed(const Duration(milliseconds: 3000), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.white));

      if (Apis.auth.currentUser != null) {
        log('\nUser : ${Apis.auth.currentUser}');
        log('\nUserAdditionalInfo : ${Apis.auth.currentUser}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome to TRANS APP"),
      ),
      body: Stack(children: [
        AnimatedPositioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            duration: Duration(seconds: 3),
            child: Image.asset("images/transcription.png")),
        //google login button
        Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            height: mq.height * .06,
            child: const Text(
              textAlign: TextAlign.center,
              "THERAPY WITH LOVE 💖",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: .5,
                  fontWeight: FontWeight.bold),
            )),
      ]),
    );
  }
}
