import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ibnu_abbas/features/main/main.dart';

class AuthLoginController extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> doSignIn(BuildContext context, String nocust, String mobilepassword) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://18.141.174.182/login'),
        body: json.encode({'nocust': nocust, 'mobilepassword': mobilepassword}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['data']['jwt_token'];

        await _storage.write(key: 'authToken', value: token);

        Navigator.pushNamed(context, MainScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid login credentials"),
        ));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred. Please try again."),
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
