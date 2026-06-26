import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/booking_model.dart';
import '../../providers/booking_provider.dart';
import 'booking_success_screen.dart';

class BookingScreen extends StatefulWidget {
  final String stationId;
  final String stationName;
  final String providerId;

  const BookingScreen({
    super.key,
    required this.stationId,
    required this.stationName,
    required this.providerId,
  });

  @override
  State<BookingScreen> createState() =>
      _BookingScreenState();
}

class _BookingScreenState
    extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
  TimeOfDay.now();

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  Future<void> confirmBooking() async {
    final date =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    final time =
    selectedTime.format(context);

    Provider.of<BookingProvider>(
      context,
      listen: false,
    ).addBooking(
      BookingModel(
        stationName:
        widget.stationName,
        date: date,
        time: time,
      ),
    );

    await FirebaseFirestore.instance
        .collection('bookings')
        .add({
      'stationId':
      widget.stationId,
      'stationName':
      widget.stationName,
      'providerId':
      widget.providerId,
      'userId':
      FirebaseAuth
          .instance
          .currentUser
          ?.uid,
      'date': date,
      'time': time,
      'status': 'Pending',
      'createdAt':
      FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BookingSuccessScreen(
              stationName:
              widget.stationName,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFF0F172A),
        title:
        const Text(
          "Book Charging Slot",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,
          children: [
            const SizedBox(
              height: 20,
            ),

            const Text(
              "Charging Station",
              style: TextStyle(
                color:
                Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              widget.stationName,
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
              height: 50,
            ),

            const Text(
              "Date",
              style: TextStyle(
                color:
                Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: pickDate,
              child: Container(
                width:
                double.infinity,
                padding:
                const EdgeInsets
                    .all(18),
                decoration:
                BoxDecoration(
                  color:
                  const Color(
                      0xFF1E293B),
                  borderRadius:
                  BorderRadius
                      .circular(
                      18),
                ),
                child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            const Text(
              "Time",
              style: TextStyle(
                color:
                Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: pickTime,
              child: Container(
                width:
                double.infinity,
                padding:
                const EdgeInsets
                    .all(18),
                decoration:
                BoxDecoration(
                  color:
                  const Color(
                      0xFF1E293B),
                  borderRadius:
                  BorderRadius
                      .circular(
                      18),
                ),
                child: Text(
                  selectedTime
                      .format(
                      context),
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width:
              double.infinity,
              height: 60,
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
                        18),
                  ),
                ),
                onPressed:
                confirmBooking,
                child:
                const Text(
                  "Confirm Booking",
                  style:
                  TextStyle(
                    fontSize: 18,
                    color:
                    Colors.white,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}