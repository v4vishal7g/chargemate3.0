import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingRequestsScreen
    extends StatelessWidget {
  const BookingRequestsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId =
        FirebaseAuth.instance.currentUser?.uid;

    print(
      "Provider UID: $userId",
    );

    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor:
        const Color(
            0xFF0F172A),
        title:
        const Text(
          "Booking Requests",
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

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error
                    .toString(),
                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),
              ),
            );
          }

          if (!snapshot
              .hasData ||
              snapshot.data!
                  .docs
                  .isEmpty) {
            return const Center(
              child: Text(
                "No Booking Requests ⚡",
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
            const EdgeInsets.all(
                20),
            itemCount:
            docs.length,
            itemBuilder:
                (
                context,
                index,
                ) {
              final doc =
              docs[index];

              final data =
              doc.data()
              as Map<
                  String,
                  dynamic>;

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
                      data['stationName'] ??
                          '',
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
                        8),

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
                        8),

                    Text(
                      "Provider: ${data['providerId'] ?? 'N/A'}",
                      style:
                      const TextStyle(
                        color:
                        Colors
                            .grey,
                        fontSize:
                        12,
                      ),
                    ),

                    const SizedBox(
                        height:
                        20),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: data['status'] != 'Pending'
                                ? null
                                : () async {
                              await FirebaseFirestore.instance
                                  .collection('bookings')
                                  .doc(doc.id)
                                  .update({
                                'status': 'Accepted',
                              });

                              final stationId =
                              data['stationId'];

                              if (stationId != null &&
                                  stationId
                                      .toString()
                                      .isNotEmpty) {
                                final stationDoc =
                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                    'stations')
                                    .doc(
                                    stationId)
                                    .get();

                                if (stationDoc.exists) {
                                  final stationData =
                                  stationDoc.data()!;

                                  int slots =
                                      int.tryParse(
                                        stationData[
                                        'slots']
                                            .toString(),
                                      ) ??
                                          0;

                                  if (slots > 0) {
                                    slots--;

                                    await FirebaseFirestore
                                        .instance
                                        .collection(
                                        'stations')
                                        .doc(
                                        stationId)
                                        .update({
                                      'slots':
                                      slots
                                          .toString(),
                                    });
                                  }
                                }
                              }

                              if (!context.mounted) {
                                return;
                              }

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Booking Accepted ✅",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              data['status'] ==
                                  'Accepted'
                                  ? 'Accepted'
                                  : 'Accept',
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.red,
                            ),
                            onPressed: data['status'] !=
                                'Pending'
                                ? null
                                : () async {
                              await FirebaseFirestore
                                  .instance
                                  .collection(
                                  'bookings')
                                  .doc(doc.id)
                                  .update({
                                'status':
                                'Rejected',
                              });

                              if (!context.mounted) {
                                return;
                              }

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Booking Rejected ❌",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              data['status'] ==
                                  'Rejected'
                                  ? 'Rejected'
                                  : 'Reject',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height:
                        15),

                    Text(
                      "Status: ${data['status'] ?? 'Pending'}",
                      style:
                      TextStyle(
                        color: data[
                        'status'] ==
                            'Accepted'
                            ? Colors
                            .green
                            : data['status'] ==
                            'Rejected'
                            ? Colors
                            .red
                            : Colors
                            .orange,
                        fontWeight:
                        FontWeight
                            .bold,
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