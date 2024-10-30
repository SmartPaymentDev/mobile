import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccountController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  String userName = '...';
  String noCust = '...';
  String kelas = '...';
  String jenjang = '...';
  String kelompok = '...';

  Future<void> fetchData() async {
    String? authToken = await storage.read(key: 'authToken');
    await fetchUser(authToken);
  }

  Future<void> fetchUser(String? authToken) async {
    final response = await http.get(
      Uri.parse('http://18.141.174.182/user/me'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      userName = data['data']['user']['nmcust'];
      noCust = data['data']['user']['nocust'];
      kelas = data['data']['user']['desc_02'];
      jenjang = data['data']['user']['code_02'];
      kelompok = data['data']['user']['desc_03'];
    }
    notifyListeners();
  }
}
