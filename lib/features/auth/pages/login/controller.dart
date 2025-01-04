import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ibnu_abbas/api.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:ibnu_abbas/features/main/pages/index/controller.dart';
import 'package:provider/provider.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class AuthLoginController extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  static const String errorMessage = "Terjadi kesalahan. Silakan coba lagi.";
  static const String invalidCredentialsMessage = "Nomor Induk Atau Password Salah";
  static const Map<String, String> storageKeys = {
    'mahasiswa': 'Mahasiswa',
    'jenjang': 'Jenjang',
    'kelas': 'Kelas',
    'kelompok': 'Kelompok',
    'nova': 'NOVA',
    'novasaku': 'NOVASAKU',
  };

  Future<void> doSignIn(
      BuildContext context, String username, String password) async {
    if (_isLoading) return;
    _setLoading(true);

    final claimSet = JwtClaim(
      otherClaims: <String, dynamic>{
        'USERNAME': username,
        'PASSWORD': password,
        'METHOD': 'LoginRequest',
      },
    );

    try {
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(Uri.parse('$apiBase$token'));
  
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['KodeRespon'] != 10) {
          await _storage.write(key: 'username', value: username);
          await _storeUserData(data);
          Provider.of<MainScreenController>(context, listen: false)
              .setSelectedIndex(0);
          Navigator.pushNamed(context, MainScreen.routeName);
        } else {
          _showSnackBar(context, invalidCredentialsMessage);
        }
      } else {
        _showSnackBar(context, errorMessage);
      }
    } catch (e) {
      debugPrint("Error during login: $e")  ;
      _showSnackBar(context, errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _storeUserData(Map<String, dynamic> data) async {
    for (final entry in storageKeys.entries) {
      await _storage.write(key: entry.key, value: data[entry.value]);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
