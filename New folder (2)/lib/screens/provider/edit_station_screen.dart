import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditStationScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const EditStationScreen({
    super.key,
    required this.docId,
    required this.data,
  });

  @override
  State<EditStationScreen> createState() =>
      _EditStationScreenState();
}

class _EditStationScreenState
    extends State<EditStationScreen> {
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController chargerController;
  late TextEditingController slotsController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
          text: widget.data['title'] ?? '',
        );

    locationController =
        TextEditingController(
          text: widget.data['location'] ?? '',
        );

    chargerController =
        TextEditingController(
          text:
          widget.data['chargerType'] ?? '',
        );

    slotsController =
        TextEditingController(
          text:
          widget.data['slots'] ?? '',
        );

    priceController =
        TextEditingController(
          text:
          widget.data['price'] ?? '',
        );
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    chargerController.dispose();
    slotsController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Widget customField({
    required TextEditingController
    controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
        const TextStyle(
          color: Colors.white70,
        ),
        prefixIcon: Icon(
          icon,
          color:
          const Color(0xFF22C55E),
        ),
        filled: true,
        fillColor:
        const Color(0xFF1E293B),
        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
              18),
          borderSide:
          BorderSide.none,
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
        const Color(
            0xFF0F172A),
        title:
        const Text(
          "Edit Station",
        ),
      ),

      body:
      SingleChildScrollView(
        padding:
        const EdgeInsets.all(
            20),
        child: Column(
          children: [
            customField(
              controller:
              titleController,
              label:
              "Station Name",
              icon:
              Icons.ev_station,
            ),

            const SizedBox(
                height: 20),

            customField(
              controller:
              locationController,
              label: "Location",
              icon:
              Icons.location_on,
            ),

            const SizedBox(
                height: 20),

            customField(
              controller:
              chargerController,
              label:
              "Charger Type",
              icon:
              Icons.bolt,
            ),

            const SizedBox(
                height: 20),

            customField(
              controller:
              slotsController,
              label:
              "Available Slots",
              icon:
              Icons.event_seat,
            ),

            const SizedBox(
                height: 20),

            customField(
              controller:
              priceController,
              label:
              "Price Per kWh",
              icon:
              Icons.currency_rupee,
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
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(
                      0xFF22C55E),
                ),
                onPressed:
                    () async {
                  await FirebaseFirestore
                      .instance
                      .collection(
                      'stations')
                      .doc(
                      widget
                          .docId)
                      .update({
                    'title':
                    titleController
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
                  });

                  if (!context
                      .mounted) {
                    return;
                  }

                  ScaffoldMessenger
                      .of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Station Updated 🎉",
                      ),
                    ),
                  );

                  Navigator.pop(
                      context);
                },
                child:
                const Text(
                  "Update Station",
                  style:
                  TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }
}