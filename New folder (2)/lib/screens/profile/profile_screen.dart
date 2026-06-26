import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../providers/favorites_provider.dart';
import '../../providers/booking_provider.dart';
import '../bookings/my_bookings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        FirebaseAuth.instance.currentUser;

    final favorites =
    Provider.of<FavoritesProvider>(
      context,
    );

    final bookings =
    Provider.of<BookingProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "👤 Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor:
              Color(0xFF22C55E),
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user?.phoneNumber ??
                  "No Number",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                    const EdgeInsets
                        .all(20),
                    decoration:
                    BoxDecoration(
                      color:
                      const Color(
                          0xFF1E293B),
                      borderRadius:
                      BorderRadius
                          .circular(
                          20),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color:
                          Colors.red,
                          size: 35,
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          "${favorites.favorites.length}",
                          style:
                          const TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            28,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                        const SizedBox(
                            height: 5),
                        const Text(
                          "Favorites",
                          style:
                          TextStyle(
                            color: Colors
                                .white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                    width: 15),

                Expanded(
                  child: Container(
                    padding:
                    const EdgeInsets
                        .all(20),
                    decoration:
                    BoxDecoration(
                      color:
                      const Color(
                          0xFF1E293B),
                      borderRadius:
                      BorderRadius
                          .circular(
                          20),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons
                              .receipt_long,
                          color:
                          Color(
                              0xFF22C55E),
                          size: 35,
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          "${bookings.bookings.length}",
                          style:
                          const TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            28,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                        const SizedBox(
                            height: 5),
                        const Text(
                          "Bookings",
                          style:
                          TextStyle(
                            color: Colors
                                .white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            ListTile(
              leading: const Icon(
                Icons.receipt_long,
                color: Colors.white,
              ),
              title: const Text(
                "My Bookings",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyBookingsScreen(),
                  ),
                );
              },
            ),

            const Divider(
              color: Colors.white24,
            ),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () async {
                await FirebaseAuth.instance
                    .signOut();

                if (!context.mounted) {
                  return;
                }

                Navigator.popUntil(
                  context,
                      (route) =>
                  route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}