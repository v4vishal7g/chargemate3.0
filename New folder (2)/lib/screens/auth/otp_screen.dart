import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../provider/complete_provider_profile_screen.dart';
import '../provider/provider_bottom_navigation_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  final String role;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phone,
    required this.role,
  });

  @override
  State<OtpScreen> createState() =>
      _OtpScreenState();
}

class _OtpScreenState
    extends State<OtpScreen> {
  final TextEditingController
  otpController =
  TextEditingController();

  bool isLoading = false;

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid 6-digit OTP",
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final credential =
      PhoneAuthProvider.credential(
        verificationId:
        widget.verificationId,
        smsCode: otp,
      );

      final userCredential =
      await FirebaseAuth.instance
          .signInWithCredential(
        credential,
      );

      final user =
          userCredential.user;

      if (user == null) {
        return;
      }

      if (widget.role ==
          'provider') {
        final providerRef =
        FirebaseFirestore.instance
            .collection(
            'providers')
            .doc(user.uid);

        final providerDoc =
        await providerRef
            .get();

        if (!providerDoc.exists) {
          await providerRef.set({
            'uid': user.uid,
            'phone':
            user.phoneNumber,
            'role':
            'provider',
            'createdAt':
            FieldValue
                .serverTimestamp(),
          });
        }

        final data =
        (await providerRef.get())
            .data();

        final name =
            data?['name']
                ?.toString() ??
                '';

        if (!mounted) {
          return;
        }

        if (name.isEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const CompleteProviderProfileScreen(),
            ),
                (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const ProviderBottomNavigationScreen(),
            ),
                (route) => false,
          );
        }
      } else {
        await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'phone':
          user.phoneNumber,
          'role': 'user',
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
            const HomeScreen(),
          ),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.message ??
                "OTP verification failed",
          ),
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
    otpController.dispose();
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
        Colors.transparent,
        elevation: 0,
        title:
        const Text("Verify OTP"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(
              24),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment
                .center,
            children: [
              const Icon(
                Icons.sms,
                size: 90,
                color:
                Color(0xFF22C55E),
              ),

              const SizedBox(
                height: 30,
              ),

              const Text(
                "OTP Verification",
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

              Text(
                "Enter OTP sent to +91 ${widget.phone}",
                textAlign:
                TextAlign.center,
                style:
                const TextStyle(
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
                otpController,
                keyboardType:
                TextInputType
                    .number,
                maxLength: 6,
                textAlign:
                TextAlign.center,
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  letterSpacing: 8,
                  fontSize: 22,
                ),
                decoration:
                InputDecoration(
                  counterText: "",
                  hintText:
                  "000000",
                  hintStyle:
                  const TextStyle(
                    color:
                    Colors.grey,
                    letterSpacing:
                    8,
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
                    BorderSide
                        .none,
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              SizedBox(
                width:
                double.infinity,
                height: 58,
                child:
                ElevatedButton(
                  onPressed:
                  isLoading
                      ? null
                      : verifyOtp,
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
                    "Verify OTP",
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
      ),
    );
  }
}