import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:lottie/lottie.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      // Navigate to the home screen after 3 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: FlareActor(
                'assets/flare/movie_icon.flr',
                animation: 'idle',
                fit: BoxFit.contain,
                callback: (name) {
                  if (name == 'idle') {
                    // Do something when the 'idle' animation is complete
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.movie_creation_outlined,
              size: 120,
            ),
            SizedBox(height: 20),
            Text(
              'Movies & Shows',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 280),
          ],
        ),
      ),
    );
  }
}
