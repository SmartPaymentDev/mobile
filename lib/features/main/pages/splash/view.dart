import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/auth/pages/login/view.dart';
import 'package:ibnu_abbas/features/main/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthLoginScreen.routeName,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PreferenceColors.purple,
        child: Center(
          child: Image.asset(
            Assets.Logo,
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
