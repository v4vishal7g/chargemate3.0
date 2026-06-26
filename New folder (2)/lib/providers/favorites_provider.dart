import 'package:flutter/material.dart';

class FavoritesProvider
    extends ChangeNotifier {

  final List<String> _favorites = [];

  List<String> get favorites =>
      _favorites;

  void toggleFavorite(
      String station) {
    if (_favorites.contains(station)) {
      _favorites.remove(station);
    } else {
      _favorites.add(station);
    }

    notifyListeners();
  }

  bool isFavorite(String station) {
    return _favorites.contains(station);
  }
}