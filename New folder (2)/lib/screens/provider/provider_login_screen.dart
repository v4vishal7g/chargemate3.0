import 'package:flutter/material.dart';
import 'provider_dashboard_screen.dart';

class ProviderLoginScreen extends StatefulWidget {
  const ProviderLoginScreen({super.key});

  @override
  State<ProviderLoginScreen> createState() =>
      _ProviderLoginScreenState();
}

class _ProviderLoginScreenState
    extends State<ProviderLoginScreen> {
  final phoneController =
  TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
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
        const Text("Provider Login"),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.business,
              size: 90,
              color:
              Color(0xFF22C55E),
            ),

            const SizedBox(
                height: 30),

            const Text(
              "Provider Sign In",
              style: TextStyle(
                color:
                Colors.white,
                fontSize: 30,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 50),

            TextField(
              controller:
              phoneController,
              keyboardType:
              TextInputType
                  .phone,
              style:
              const TextStyle(
                color:
                Colors.white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Enter Mobile Number",
                hintStyle:
                const TextStyle(
                  color:
                  Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.phone,
                  color:
                  Color(
                      0xFF22C55E),
                ),
                filled: true,
                fillColor:
                const Color(
                    0xFF1E293B),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      18),
                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
                height: 30),

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
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        18),
                  ),
                ),
                onPressed: () {
                  if (phoneController
                      .text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Enter Mobile Number",
                        ),
                      ),
                    );
                    return;
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const ProviderDashboardScreen(),
                    ),
                  );
                },
                child:
                const Text(
                  "Continue",
                  style:
                  TextStyle(
                    color:
                    Colors.white,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
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