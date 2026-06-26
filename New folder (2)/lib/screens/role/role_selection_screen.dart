import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class RoleSelectionScreen
    extends StatelessWidget {
  const RoleSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding:
          const EdgeInsets.all(
            20,
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment
                .center,
            children: [
              const Text(
                "ChargeMate",
                style: TextStyle(
                  color:
                  Colors.white,
                  fontSize: 36,
                  fontWeight:
                  FontWeight
                      .bold,
                ),
              ),

              const SizedBox(
                height: 60,
              ),

              SizedBox(
                width:
                double.infinity,
                height: 60,
                child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const LoginScreen(
                          role:
                          'user',
                        ),
                      ),
                    );
                  },
                  child:
                  const Text(
                    "Continue as User",
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                double.infinity,
                height: 60,
                child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const LoginScreen(
                          role:
                          'provider',
                        ),
                      ),
                    );
                  },
                  child:
                  const Text(
                    "Continue as Provider",
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