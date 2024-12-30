import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ibnu_abbas/api.dart';
import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';

class BillController extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool isLoading = false;
  List<dynamic> bills = [];

  Future<void> fetchBills() async {
    isLoading = true;
    notifyListeners();

    String? username = await _storage.read(key: 'username');

    if (username == null) {
      print('Auth token is null');
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final claimSet = JwtClaim(
        otherClaims: <String, dynamic>{
          'USERNAME': username,
          'METHOD': 'BillRequest',
        },
      );
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        bills = data['datas'] ?? {};
      } else {
        print(
            'Error: ${response.reasonPhrase}'); 
        bills = [];
      }
    } catch (e) {
      print('Network error: $e'); 
    }

    isLoading = false;
    notifyListeners();
  }
}
