import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'booking_requests_screen.dart';
import 'add_station_screen.dart';
import 'my_stations_screen.dart';
import 'provider_bookings_screen.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

        appBar: AppBar(
          backgroundColor:
          const Color(0xFF0F172A),
          elevation: 0,
          automaticallyImplyLeading:
          false,
          title: const Text(
            "🏢 Provider Dashboard",
            style: TextStyle(
              fontWeight:
              FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon:
              const CircleAvatar(
                radius: 16,
                backgroundColor:
                Color(
                    0xFF22C55E),
                child: Icon(
                  Icons.person,
                  color:
                  Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('providers')
                  .doc(
                FirebaseAuth
                    .instance
                    .currentUser!
                    .uid,
              )
                  .snapshots(),
              builder: (
                  context,
                  snapshot,
                  ) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(
                      color:
                      Color(0xFF22C55E),
                    ),
                  );
                }

                final data =
                snapshot.data?.data()
                as Map<String, dynamic>?;

                final name =
                    data?['name'] ??
                        'Provider';

                final email =
                    data?['email'] ??
                        '';

                final phone =
                    data?['phone'] ??
                        '';

                final company =
                    data?['companyName'] ??
                        '';

                return Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(
                      20),
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                        0xFF1E293B),
                    borderRadius:
                    BorderRadius
                        .circular(
                        25),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor:
                        Color(
                            0xFF22C55E),
                        child: Icon(
                          Icons.business,
                          color:
                          Colors.white,
                          size: 35,
                        ),
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              name,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white,
                                fontSize:
                                22,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              email,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white70,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              phone,
                              style:
                              const TextStyle(
                                color:
                                Colors
                                    .white70,
                              ),
                            ),

                            if (company
                                .isNotEmpty)
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                  top: 4,
                                ),
                                child: Text(
                                  "🏢 $company",
                                  style:
                                  const TextStyle(
                                    color:
                                    Colors
                                        .white70,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: StreamBuilder<
                      QuerySnapshot>(
                    stream:
                    FirebaseFirestore
                        .instance
                        .collection(
                        'stations')
                        .where(
                      'ownerId',
                      isEqualTo:
                      FirebaseAuth
                          .instance
                          .currentUser
                          ?.uid,
                    )
                        .snapshots(),
                    builder: (
                        context,
                        snapshot,
                        ) {
                      final count =
                          snapshot
                              .data
                              ?.docs
                              .length ??
                              0;

                      return statCard(
                        Icons.ev_station,
                        "Stations",
                        count.toString(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: StreamBuilder<
                      QuerySnapshot>(
                    stream:
                    FirebaseFirestore
                        .instance
                        .collection(
                        'bookings')
                        .where(
                      'providerId',
                      isEqualTo:
                      FirebaseAuth
                          .instance
                          .currentUser
                          ?.uid,
                    )
                        .snapshots(),
                    builder: (
                        context,
                        snapshot,
                        ) {
                      final count =
                          snapshot
                              .data
                              ?.docs
                              .length ??
                              0;

                      return statCard(
                        Icons.book_online,
                        "Bookings",
                        count.toString(),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            const Text(
              "Quick Actions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            dashboardCard(
              context,
              Icons.add_business,
              "Add Station",
              "Create a new charging station",
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const AddStationScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            dashboardCard(
              context,
              Icons.ev_station,
              "My Stations",
              "Manage all stations",
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const MyStationsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            dashboardCard(
              context,
              Icons.book_online,
              "Bookings",
              "View station bookings",
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const ProviderBookingsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            dashboardCard(
              context,
              Icons.receipt_long,
              "Booking Requests",
              "Accept or reject bookings",
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const BookingRequestsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            dashboardCard(
              context,
              Icons.logout,
              "Logout",
              "Sign out from provider account",
                  () async {
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

  Widget dashboardCard(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(20),
      child: Container(
        padding:
        const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
          const Color(0xFF1E293B),
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
              const Color(
                  0xFF22C55E),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    title,
                    style:
                    const TextStyle(
                      color:
                      Colors.white,
                      fontSize: 20,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  Text(
                    subtitle,
                    style:
                    const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
  Widget statCard(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      padding:
      const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
        const Color(0xFF1E293B),
        borderRadius:
        BorderRadius.circular(
            20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color:
            const Color(
                0xFF22C55E),
            size: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style:
            const TextStyle(
              color:
              Colors.white,
              fontSize: 28,
              fontWeight:
              FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style:
            const TextStyle(
              color:
              Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}