import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId =
        FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFF0F172A),
        title:
        const Text(
          "My Bookings",
        ),
      ),

      body:
      StreamBuilder<
          QuerySnapshot>(
        stream:
        FirebaseFirestore
            .instance
            .collection(
            'bookings')
            .where(
          'userId',
          isEqualTo:
          userId,
        )
            .orderBy(
          'createdAt',
          descending:
          true,
        )
            .snapshots(),
        builder: (
            context,
            snapshot,
            ) {
          if (snapshot
              .connectionState ==
              ConnectionState
                  .waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (!snapshot
              .hasData ||
              snapshot.data!
                  .docs
                  .isEmpty) {
            return const Center(
              child: Text(
                "No Bookings Yet ⚡",
                style:
                TextStyle(
                  color:
                  Colors.white,
                  fontSize:
                  22,
                ),
              ),
            );
          }

          final docs =
              snapshot
                  .data!
                  .docs;

          return ListView.builder(
            padding:
            const EdgeInsets
                .all(20),
            itemCount:
            docs.length,
            itemBuilder:
                (
                context,
                index,
                ) {
              final data =
              docs[index]
                  .data()
              as Map<
                  String,
                  dynamic>;

              final status =
                  data['status'] ??
                      'Pending';

              Color statusColor =
                  Colors.orange;

              if (status ==
                  'Accepted') {
                statusColor =
                    Colors.green;
              } else if (status ==
                  'Rejected') {
                statusColor =
                    Colors.red;
              }

              return Container(
                margin:
                const EdgeInsets
                    .only(
                  bottom:
                  20,
                ),
                padding:
                const EdgeInsets
                    .all(
                    20),
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
                child:
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      "⚡ ${data['stationName'] ?? ''}",
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
                        height:
                        10),

                    Text(
                      "📅 ${data['date'] ?? ''}",
                      style:
                      const TextStyle(
                        color:
                        Colors
                            .white70,
                      ),
                    ),

                    const SizedBox(
                        height:
                        5),

                    Text(
                      "🕐 ${data['time'] ?? ''}",
                      style:
                      const TextStyle(
                        color:
                        Colors
                            .white70,
                      ),
                    ),

                    const SizedBox(
                        height:
                        10),

                    Text(
                      "Status: $status",
                      style:
                      TextStyle(
                        color:
                        statusColor,
                        fontWeight:
                        FontWeight
                            .bold,
                        fontSize:
                        16,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}