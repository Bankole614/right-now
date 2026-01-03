// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../services/preferences_service.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideRouteAfterDelay();
  }

  Future<void> _decideRouteAfterDelay() async {
    // keep the splash visible for the same duration you had before
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;

    try {

      // 2) no token -> check onboarding flag via PreferencesService
      final bool onboardingDone = await PreferencesService.isOnboardingDone();

      if (!onboardingDone) {
        Navigator.of(context).pushReplacementNamed('/onboarding');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      // fallback to onboarding/login if anything goes wrong
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        kGradientStart,
        kGradientEnd,
      ],
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/rnlogo.png',
                fit: BoxFit.contain,
                semanticLabel: 'RightNow logo',
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
