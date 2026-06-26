import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../providers/favorites_provider.dart';
import '../booking/booking_screen.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() =>
      _StationsScreenState();
}

class _StationsScreenState
    extends State<StationsScreen> {
  final TextEditingController
  searchController =
  TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading:
        false,
        title: const Text(
          "⚡ Charging Stations",
          style: TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.all(
                20),
            child: TextField(
              controller:
              searchController,
              style:
              const TextStyle(
                color:
                Colors.white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Search station",
                hintStyle:
                const TextStyle(
                  color:
                  Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.search,
                  color:
                  Colors.grey,
                ),
                filled: true,
                fillColor:
                const Color(
                    0xFF1E293B),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      18),
                  borderSide:
                  BorderSide.none,
                ),
              ),
              onChanged:
                  (value) {
                setState(() {
                  searchText =
                      value
                          .toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child:
            StreamBuilder<
                QuerySnapshot>(
              stream:
              FirebaseFirestore
                  .instance
                  .collection(
                  'stations')
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

                if (snapshot
                    .hasError) {
                  return Center(
                    child: Text(
                      snapshot.error
                          .toString(),
                      style:
                      const TextStyle(
                        color: Colors
                            .white,
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
                      "No Stations Found ⚡",
                      style:
                      TextStyle(
                        color: Colors
                            .white70,
                        fontSize:
                        20,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  );
                }

                final docs =
                    snapshot
                        .data!
                        .docs;

                final filteredDocs =
                docs.where(
                      (doc) {
                    final data =
                    doc.data()
                    as Map<
                        String,
                        dynamic>;

                    final title =
                    (data['title'] ??
                        '')
                        .toString()
                        .toLowerCase();

                    final location =
                    (data['location'] ??
                        '')
                        .toString()
                        .toLowerCase();

                    return title
                        .contains(
                        searchText) ||
                        location
                            .contains(
                            searchText);
                  },
                ).toList();

                if (filteredDocs
                    .isEmpty) {
                  return const Center(
                    child: Text(
                      "No Stations Found ⚡",
                      style:
                      TextStyle(
                        color: Colors
                            .white70,
                        fontSize:
                        20,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  );
                }

                return ListView
                    .builder(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal:
                    20,
                  ),
                  itemCount:
                  filteredDocs
                      .length,
                  itemBuilder:
                      (context,
                      index) {
                    final data =
                    filteredDocs[
                    index]
                        .data()
                    as Map<
                        String,
                        dynamic>;

                    return stationCard(
                      context,
                      filteredDocs[index].id,
                      data['title'] ?? '',
                      data['location'] ?? '',
                      data['chargerType'] ?? '',
                      data['slots'] ?? '',
                      data['rating'] ?? 'New',
                      data['ownerId'] ?? '',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget stationCard(
      BuildContext context,
      String stationId,
      String title,
      String location,
      String chargerType,
      String slots,
      String rating,
      String ownerId,
      ) {
    final provider =
    context.watch<
        FavoritesProvider>();

    final isFavorite =
    provider.isFavorite(
      title,
    );

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
        BorderRadius
            .circular(
            20),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                  const TextStyle(
                    color: Colors
                        .white,
                    fontSize:
                    22,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    () {
                  provider
                      .toggleFavorite(
                    title,
                  );
                },
                icon: Icon(
                  isFavorite
                      ? Icons
                      .favorite
                      : Icons
                      .favorite_border,
                  color:
                  Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 10),

          Text(
            "📍 $location",
            style:
            const TextStyle(
              color: Colors
                  .white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(
              height: 8),

          Text(
            "🔌 $chargerType",
            style:
            const TextStyle(
              color: Colors
                  .white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(
              height: 8),

          Text(
            "🟢 $slots Slots Available",
            style:
            const TextStyle(
              color:
              Colors.green,
              fontSize: 16,
            ),
          ),

          const SizedBox(
              height: 8),

          Text(
            "⭐ $rating",
            style:
            const TextStyle(
              color:
              Colors.amber,
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 20),

          SizedBox(
            width:
            double.infinity,
            height: 50,
            child:
            ElevatedButton(
              style:
              ElevatedButton
                  .styleFrom(
                backgroundColor:
                const Color(
                    0xFF22C55E),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      15),
                ),
              ),
              onPressed:
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) =>
                            BookingScreen(
                              stationId: stationId,
                              stationName: title,
                              providerId: ownerId,
                            ),
                  ),
                );
              },
              child:
              const Text(
                "Book Now",
                style:
                TextStyle(
                  color:
                  Colors.white,
                  fontSize:
                  18,
                  fontWeight:
                  FontWeight
                      .bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}