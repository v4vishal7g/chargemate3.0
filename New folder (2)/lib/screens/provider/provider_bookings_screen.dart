import 'package:flutter/material.dart';

class ProviderBookingsScreen
    extends StatelessWidget {
  const ProviderBookingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor:
        const Color(0xFF0F172A),
        title:
        const Text("Bookings"),
      ),
      body: const Center(
        child: Text(
          "No Bookings Yet 📅",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}