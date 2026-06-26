import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  final List<BookingModel> _bookings = [];

  List<BookingModel> get bookings =>
      _bookings;

  void addBooking(
      BookingModel booking,
      ) {
    _bookings.add(booking);
    notifyListeners();
  }
}