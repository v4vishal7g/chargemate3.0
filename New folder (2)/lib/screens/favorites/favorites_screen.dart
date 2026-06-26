import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';

class FavoritesScreen
    extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<FavoritesProvider>(
      context,
    );

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
          "❤️ Favorites",
          style: TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: provider
          .favorites.isEmpty
          ? const Center(
        child: Text(
          "No Favorites Yet ❤️",
          style: TextStyle(
            color:
            Colors.white,
            fontSize: 22,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets
            .all(20),
        itemCount: provider
            .favorites.length,
        itemBuilder:
            (context, index) {
          final station =
          provider
              .favorites[
          index];

          return Container(
            margin:
            const EdgeInsets
                .only(
              bottom: 15,
            ),
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
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color:
                  Colors.red,
                  size: 30,
                ),

                const SizedBox(
                  width: 15,
                ),

                Expanded(
                  child: Text(
                    station,
                    style:
                    const TextStyle(
                      color:
                      Colors
                          .white,
                      fontSize:
                      18,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}