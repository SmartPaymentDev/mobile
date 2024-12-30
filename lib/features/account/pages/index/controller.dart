import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ibnu_abbas/features/auth/pages/login/view.dart';

class AccountController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  String mahasiswa = '...';
  String nova = '...';
  String kelas = '...';
  String jenjang = '...';
  String kelompok = '...';

  Future<void> fetchData() async {
    await fetchUser();
  }

  Future<void> fetchUser() async {
    mahasiswa = await storage.read(key: 'mahasiswa') ?? '...';
    nova = await storage.read(key: 'nova') ?? '...';
    kelas = await storage.read(key: 'kelas') ?? '...';
    jenjang = await storage.read(key: 'jenjang') ?? '...';
    kelompok = await storage.read(key: 'kelompok') ?? '...';

    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'mahasiswa');
    await storage.delete(key: 'nova');
    await storage.delete(key: 'kelas');
    await storage.delete(key: 'jenjang');
    await storage.delete(key: 'kelompok');
    await storage.delete(key: 'novasaku');
    Navigator.pushNamed(context, AuthLoginScreen.routeName);
  }
}
