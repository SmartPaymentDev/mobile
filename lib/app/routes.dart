import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:ibnu_abbas/features/auth/auth.dart';
import 'package:ibnu_abbas/features/reset-pass/pages/index/view.dart';
import 'package:ibnu_abbas/features/saku/saku.dart';
import 'package:ibnu_abbas/features/spp/spp.dart';

Route<dynamic> routes(RouteSettings settings) {
  WidgetBuilder builder;
  final storage = FlutterSecureStorage();

  switch (settings.name) {
    case MainScreen.routeName:
      builder = (_) => const MainScreen();
      break;
    case AuthLoginScreen.routeName:
      // Check if user is logged in
      return MaterialPageRoute(
        builder: (context) => FutureBuilder<String?>(
          future: storage.read(key: 'nova'),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const MainScreen();
            }
            return AuthLoginScreen();
          },
        ),
      );
    case SppScreen.routeName:
      builder = (_) => SppScreen();
      break;
    case SakuScreen.routeName:
      builder = (_) => SakuScreen();
      break;
    case ResetPassScreen.routeName:
      builder = (_) => ResetPassScreen();
      break;
    default:
      builder = (_) => const Scaffold(
            body: Center(child: Text('Page Not Found!')),
          );
  }

  return MaterialPageRoute(builder: builder);
}
