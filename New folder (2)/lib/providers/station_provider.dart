import 'package:flutter/material.dart';
import '../models/station_model.dart';

class StationProvider extends ChangeNotifier {
  final List<StationModel> _stations = [];

  List<StationModel> get stations => _stations;

  void addStation(StationModel station) {
    _stations.add(station);
    notifyListeners();
  }
}