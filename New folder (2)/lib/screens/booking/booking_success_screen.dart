import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String stationName;

  const BookingSuccessScreen({
    super.key,
    required this.stationName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
    body: SafeArea(
    child: Padding(
        padding: const EdgeInsets.all(25),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Icon(
    Icons.access_time_filled,
    size: 120,
    color: Colors.orange,
    ),

    const SizedBox(height: 30),

    const Text(
    "Booking Request Sent 🎉",
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 20),

    Text(
    stationName,
    textAlign: TextAlign.center,
    style: const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    ),
    ),

    const SizedBox(height: 20),

    const Text(
    "Your booking is currently Pending.\nPlease wait for the provider to Accept or Reject your request.",
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white70,
    fontSize: 18,
    height: 1.5,
    ),
    ),

    const SizedBox(height: 50),

    SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor:
    const Color(0xFF22C55E),
    shape: RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(16),
    ),
    ),
    onPressed: () {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const HomeScreen(),
    ),
    (route) => false,
    );
    },
    child: const Text(
    "Back to Home",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight:
    FontWeight.bold,
    ),
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
