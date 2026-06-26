import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  final String role;

  const LoginScreen({
    super.key,
    required this.role,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final TextEditingController
  phoneController =
  TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    final phone =
    phoneController.text.trim();

    if (phone.length != 10) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid 10-digit mobile number",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await AuthService.sendOtp(
      phone: phone,

      onCodeSent:
          (verificationId) {
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                OtpScreen(
                  verificationId:
                  verificationId,
                  phone: phone,
                  role: widget.role,
                ),
          ),
        );
      },

      onError: (error) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
    );
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
        title: Text(
          widget.role ==
              'provider'
              ? "Provider Login"
              : "User Login",
        ),
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
                Icons.ev_station,
                size: 90,
                color:
                Color(0xFF22C55E),
              ),

              const SizedBox(
                height: 30,
              ),

              Text(
                widget.role ==
                    'provider'
                    ? "Provider Login"
                    : "User Login",
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontSize: 28,
                  fontWeight:
                  FontWeight
                      .bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Enter your mobile number",
                style:
                TextStyle(
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
                phoneController,
                keyboardType:
                TextInputType
                    .phone,
                maxLength: 10,
                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),
                decoration:
                InputDecoration(
                  counterText: "",
                  prefixText:
                  "+91 ",
                  prefixStyle:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize:
                    18,
                  ),
                  hintText:
                  "9876543210",
                  hintStyle:
                  const TextStyle(
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
                      : sendOtp,
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
                    "Send OTP",
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