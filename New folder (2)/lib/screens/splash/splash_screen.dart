import 'dart:async';
import 'package:flutter/material.dart';
import '../role/role_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const RoleSelectionScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.ev_station,
              size: 90,
              color:
              Color(0xFF22C55E),
            ),
            SizedBox(height: 20),
            Text(
              "ChargeMate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Find • Charge • Go",
              style: TextStyle(
                color:
                Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}