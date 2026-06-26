import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return homeBody();
  }

  Widget homeBody() {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "⚡ ChargeMate",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Evening 👋",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Find EV Charging Stations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              decoration: InputDecoration(
                hintText:
                "Search charging station",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor:
                const Color(0xFF1E293B),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      18),
                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Nearby Stations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            stationCard(
              "EV Fast Charger",
              "Koramangala",
              "4.8",
            ),

            const SizedBox(height: 15),

            stationCard(
              "Super Charge Hub",
              "HSR Layout",
              "4.6",
            ),
          ],
        ),
      ),
    );
  }

  Widget stationCard(
      String title,
      String location,
      String rating,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor:
            Color(0xFF22C55E),
            child: Icon(
              Icons.ev_station,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "📍 $location",
                  style:
                  const TextStyle(
                    color:
                    Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Text(
            "⭐ $rating",
            style:
            const TextStyle(
              color: Colors.amber,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}