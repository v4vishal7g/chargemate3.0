import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'provider_dashboard_screen.dart';

class CompleteProviderProfileScreen
    extends StatefulWidget {
  const CompleteProviderProfileScreen({
    super.key,
  });

  @override
  State<CompleteProviderProfileScreen>
  createState() =>
      _CompleteProviderProfileScreenState();
}

class _CompleteProviderProfileScreenState
    extends State<
        CompleteProviderProfileScreen> {
  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final companyController =
  TextEditingController();

  bool isLoading = false;

  Future<void> saveProfile() async {
    final name =
    nameController.text.trim();

    final email =
    emailController.text.trim();

    final company =
    companyController.text.trim();

    if (name.isEmpty ||
        email.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter name and email",
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user =
      FirebaseAuth
          .instance
          .currentUser!;

      await FirebaseFirestore.instance
          .collection('providers')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'phone':
        user.phoneNumber,
        'role':
        'provider',
        'name': name,
        'email': email,
        'companyName':
        company,
        'createdAt':
        FieldValue
            .serverTimestamp(),
      });

      if (!mounted) {
        return;
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const ProviderDashboardScreen(),
        ),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
          Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor:
        const Color(
            0xFF0F172A),
        title: const Text(
          "Complete Profile",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
            24),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            const CircleAvatar(
              radius: 50,
              backgroundColor:
              Color(0xFF22C55E),
              child: Icon(
                Icons.business,
                size: 50,
                color:
                Colors.white,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            const Text(
              "Complete Your Profile",
              style: TextStyle(
                color:
                Colors.white,
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Enter your details to continue",
              style: TextStyle(
                color:
                Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            TextField(
              controller:
              nameController,
              style:
              const TextStyle(
                color:
                Colors.white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Full Name",
                hintStyle:
                const TextStyle(
                  color:
                  Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.person,
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
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
              emailController,
              keyboardType:
              TextInputType
                  .emailAddress,
              style:
              const TextStyle(
                color:
                Colors.white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Email Address",
                hintStyle:
                const TextStyle(
                  color:
                  Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.email,
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
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
              companyController,
              style:
              const TextStyle(
                color:
                Colors.white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Company Name (Optional)",
                hintStyle:
                const TextStyle(
                  color:
                  Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.business,
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
            ),

            const Spacer(),

            SizedBox(
              width:
              double.infinity,
              height: 60,
              child:
              ElevatedButton(
                onPressed:
                isLoading
                    ? null
                    : saveProfile,
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
                child: isLoading
                    ? const CircularProgressIndicator(
                  color:
                  Colors
                      .white,
                )
                    : const Text(
                  "Save & Continue",
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