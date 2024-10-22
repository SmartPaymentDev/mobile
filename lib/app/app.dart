import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/core/preferences/preferences.dart';
import 'package:ibnu_abbas/features/auth/pages/login/view.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar',
      debugShowCheckedModeBanner: false,
      theme: ThemeLight(PreferenceColors.purple).theme,
      home:  AuthLoginScreen(),
      onGenerateRoute: routes,
    );
  }
}