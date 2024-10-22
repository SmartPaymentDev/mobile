// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/main/pages/index/controller.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainScreenController()),
  ], child: const App()));
}