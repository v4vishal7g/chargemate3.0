import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../models/station_model.dart';
import '../../providers/station_provider.dart';

class AddStationScreen extends StatefulWidget {
  const AddStationScreen({super.key});

  @override
  State<AddStationScreen> createState() =>
      _AddStationScreenState();
}

class _AddStationScreenState
    extends State<AddStationScreen> {
  final stationController =
  TextEditingController();

  final locationController =
  TextEditingController();

  final chargerController =
  TextEditingController();

  final slotsController =
  TextEditingController();

  final priceController =
  TextEditingController();

  @override
  void dispose() {
    stationController.dispose();
    locationController.dispose();
    chargerController.dispose();
    slotsController.dispose();
    priceController.dispose();
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
        title:
        const Text("Add Station"),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          children: [
            textField(
              controller:
              stationController,
              label:
              "Station Name",
              icon:
              Icons.ev_station,
            ),

            const SizedBox(
                height: 20),

            textField(
              controller:
              locationController,
              label: "Location",
              icon:
              Icons.location_on,
            ),

            const SizedBox(
                height: 20),

            textField(
              controller:
              chargerController,
              label:
              "Charger Type",
              icon:
              Icons.bolt,
            ),

            const SizedBox(
                height: 20),

            textField(
              controller:
              slotsController,
              label:
              "Available Slots",
              icon:
              Icons.event_seat,
              keyboardType:
              TextInputType
                  .number,
            ),

            const SizedBox(
                height: 20),

            textField(
              controller:
              priceController,
              label:
              "Price Per kWh",
              icon:
              Icons.currency_rupee,
              keyboardType:
              TextInputType
                  .number,
            ),

            const SizedBox(
                height: 40),

            SizedBox(
              width:
              double.infinity,
              height: 55,
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
                    () async {
                  if (stationController
                      .text
                      .trim()
                      .isEmpty ||
                      locationController
                          .text
                          .trim()
                          .isEmpty ||
                      chargerController
                          .text
                          .trim()
                          .isEmpty ||
                      slotsController
                          .text
                          .trim()
                          .isEmpty ||
                      priceController
                          .text
                          .trim()
                          .isEmpty) {
                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      const SnackBar(
                        content:
                        Text(
                          "Please fill all fields",
                        ),
                      ),
                    );
                    return;
                  }

                  try {
                    final station =
                    StationModel(
                      title:
                      stationController
                          .text
                          .trim(),
                      location:
                      locationController
                          .text
                          .trim(),
                      chargerType:
                      chargerController
                          .text
                          .trim(),
                      slots:
                      slotsController
                          .text
                          .trim(),
                      rating:
                      "New",
                    );

                    Provider.of<
                        StationProvider>(
                      context,
                      listen:
                      false,
                    ).addStation(
                      station,
                    );

                    await FirebaseFirestore
                        .instance
                        .collection(
                        'stations')
                        .add({
                      'ownerId':
                      FirebaseAuth
                          .instance
                          .currentUser
                          ?.uid ??
                          '',
                      'title':
                      stationController
                          .text
                          .trim(),
                      'location':
                      locationController
                          .text
                          .trim(),
                      'chargerType':
                      chargerController
                          .text
                          .trim(),
                      'slots':
                      slotsController
                          .text
                          .trim(),
                      'price':
                      priceController
                          .text
                          .trim(),
                      'rating':
                      'New',
                      'createdAt':
                      FieldValue
                          .serverTimestamp(),
                    });

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
                          "Station Added Successfully 🎉",
                        ),
                      ),
                    );

                    Navigator.pop(
                        context);
                  } catch (e) {
                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      SnackBar(
                        content:
                        Text(
                          "Error: $e",
                        ),
                      ),
                    );
                  }
                },
                child:
                const Text(
                  "Save Station",
                  style:
                  TextStyle(
                    fontSize:
                    18,
                    color:
                    Colors
                        .white,
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

  Widget textField({
    required TextEditingController
    controller,
    required String label,
    required IconData icon,
    TextInputType
    keyboardType =
        TextInputType.text,
  }) {
    return TextField(
      controller:
      controller,
      keyboardType:
      keyboardType,
      style:
      const TextStyle(
        color:
        Colors.white,
      ),
      decoration:
      InputDecoration(
        labelText:
        label,
        labelStyle:
        const TextStyle(
          color:
          Colors.white70,
        ),
        prefixIcon: Icon(
          icon,
          color:
          const Color(
              0xFF22C55E),
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
    );
  }
}