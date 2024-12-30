import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ibnu_abbas/api.dart';
import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';

class PaymentController extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool isLoading = false;
  List<dynamic> payments = [];

  Future<void> fetchPayments() async {
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
          'METHOD': 'PaymentRequest',
        },
      );
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        payments = data['datas'] ?? {};
      } else {
        print('Error: ${response.reasonPhrase}'); 
        payments = [];
      }
    } catch (e) {
      print('Network error: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
