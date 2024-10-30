import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool isLoading = false;
  List<dynamic> payments = [];

  Future<void> fetchPayments() async {
    isLoading = true;
    notifyListeners();

    final authToken = await _storage.read(key: 'authToken');
    print('Auth Token: $authToken'); // Debugging auth token retrieval

    if (authToken == null) {
      print('Auth token is null');
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://18.141.174.182/bills?paid_st=1'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      print('Status Code: ${response.statusCode}'); // Print status code

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response Data: $data'); // Debugging the response
        payments = data['data']['bills'] ?? [];
      } else {
        print('Error: ${response.reasonPhrase}'); // Print error if status code is not 200
        payments = [];
      }
    } catch (e) {
      print('Network error: $e'); // Print network error if it occurs
    }

    isLoading = false;
    notifyListeners();
  }
}
