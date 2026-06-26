import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_station_screen.dart';
class MyStationsScreen extends StatelessWidget {
  const MyStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId =
        FirebaseAuth.instance.currentUser?.uid ??
            'demo_provider';

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text("My Stations"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('stations')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Stations Added Yet ⚡",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding:
            const EdgeInsets.all(20),
            itemCount: docs.length,
            itemBuilder:
                (context, index) {
              final doc =
              docs[index];

              final data =
              doc.data()
              as Map<String,
                  dynamic>;

              return Container(
                margin:
                const EdgeInsets.only(
                  bottom: 20,
                ),
                padding:
                const EdgeInsets.all(
                    20),
                decoration:
                BoxDecoration(
                  color:
                  const Color(
                      0xFF1E293B),
                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      data['title'] ??
                          '',
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      "📍 ${data['location'] ?? ''}",
                      style:
                      const TextStyle(
                        color:
                        Colors.white70,
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    Text(
                      "🔌 ${data['chargerType'] ?? ''}",
                      style:
                      const TextStyle(
                        color:
                        Colors.white70,
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    Text(
                      "🟢 ${data['slots'] ?? '0'} Slots Available",
                      style:
                      const TextStyle(
                        color:
                        Colors.green,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    Row(
                      children: [
                        Expanded(
                          child:
                          ElevatedButton
                              .icon(
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(
                                  0xFF22C55E),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditStationScreen(
                                        docId: doc.id,
                                        data: data,
                                      ),
                                ),
                              );
                            },
                            icon:
                            const Icon(
                              Icons.edit,
                              color:
                              Colors.white,
                            ),
                            label:
                            const Text(
                              "Edit",
                              style:
                              TextStyle(
                                color:
                                Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 15),

                        Expanded(
                          child:
                          ElevatedButton
                              .icon(
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.red,
                            ),
                            onPressed:
                                () async {
                              final confirm =
                              await showDialog<
                                  bool>(
                                context:
                                context,
                                builder:
                                    (
                                    context,
                                    ) {
                                  return AlertDialog(
                                    title:
                                    const Text(
                                      "Delete Station",
                                    ),
                                    content:
                                    const Text(
                                      "Are you sure you want to delete this station?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                            context,
                                            false,
                                          );
                                        },
                                        child:
                                        const Text(
                                          "Cancel",
                                        ),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                            context,
                                            true,
                                          );
                                        },
                                        child:
                                        const Text(
                                          "Delete",
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm ==
                                  true) {
                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                    'stations')
                                    .doc(
                                    doc.id)
                                    .delete();

                                if (!context
                                    .mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content:
                                    Text(
                                      "Station Deleted 🗑️",
                                    ),
                                  ),
                                );
                              }
                            },
                            icon:
                            const Icon(
                              Icons.delete,
                              color:
                              Colors.white,
                            ),
                            label:
                            const Text(
                              "Delete",
                              style:
                              TextStyle(
                                color:
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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