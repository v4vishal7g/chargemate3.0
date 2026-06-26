import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProviderProfileScreen
    extends StatefulWidget {
  const EditProviderProfileScreen({
    super.key,
  });

  @override
  State<EditProviderProfileScreen>
  createState() =>
      _EditProviderProfileScreenState();
}

class _EditProviderProfileScreenState
    extends State<
        EditProviderProfileScreen> {
  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final companyController =
  TextEditingController();

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user =
    FirebaseAuth.instance.currentUser!;

    final doc =
    await FirebaseFirestore.instance
        .collection('providers')
        .doc(user.uid)
        .get();

    final data = doc.data();

    if (data != null) {
      nameController.text =
          data['name'] ?? '';

      emailController.text =
          data['email'] ?? '';

      companyController.text =
          data['companyName'] ?? '';
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateProfile() async {
    if (nameController.text
        .trim()
        .isEmpty ||
        emailController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Name and Email are required",
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isSaving = true;
      });

      final user =
      FirebaseAuth
          .instance
          .currentUser!;

      await FirebaseFirestore.instance
          .collection('providers')
          .doc(user.uid)
          .update({
        'name':
        nameController.text.trim(),
        'email':
        emailController.text.trim(),
        'companyName':
        companyController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Profile Updated ✅",
          ),
        ),
      );

      Navigator.pop(context);
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
          isSaving = false;
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
          "Edit Profile",
        ),
      ),

      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(
          color:
          Color(
              0xFF22C55E),
        ),
      )
          : Padding(
        padding:
        const EdgeInsets
            .all(20),
        child: Column(
          children: [
            TextField(
              controller:
              nameController,
              style:
              const TextStyle(
                color:
                Colors
                    .white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Full Name",
                filled:
                true,
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
              height: 20,
            ),

            TextField(
              controller:
              emailController,
              style:
              const TextStyle(
                color:
                Colors
                    .white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Email",
                filled:
                true,
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
              height: 20,
            ),

            TextField(
              controller:
              companyController,
              style:
              const TextStyle(
                color:
                Colors
                    .white,
              ),
              decoration:
              InputDecoration(
                hintText:
                "Company Name",
                filled:
                true,
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

            const Spacer(),

            SizedBox(
              width:
              double.infinity,
              height: 55,
              child:
              ElevatedButton(
                onPressed:
                isSaving
                    ? null
                    : updateProfile,
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(
                      0xFF22C55E),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(
                  color:
                  Colors
                      .white,
                )
                    : const Text(
                  "Update Profile",
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