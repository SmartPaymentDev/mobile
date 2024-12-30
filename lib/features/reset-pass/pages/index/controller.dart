import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ibnu_abbas/api.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:ibnu_abbas/features/main/pages/index/controller.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:provider/provider.dart';

class ResetPasssController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  bool _isLoading = false;

  String noCust = '...';

  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    String? authToken = await storage.read(key: 'authToken');
    await fetchUser(authToken);
  }

  Future<void> changePass(
      BuildContext context, String newPassword, String confirmPassword) async {
    if (newPassword == '' || confirmPassword == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Semua Field Harus Diisi"),
      ));
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Baru Tidak Sama"),
      ));
      return;
    }

    String? username = await storage.read(key: 'username');

    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final claimSet = JwtClaim(
        otherClaims: <String, dynamic>{
          'USERNAME': username,
          'NEWPASSWORD': newPassword,
          'NEWPASSWORD2': confirmPassword,
          'METHOD': 'RequestNewPassword'
        },
      );
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['KodeRespon'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Berhasil!"),
          ));
          Provider.of<MainScreenController>(context, listen: false)
              .setSelectedIndex(3);
          Navigator.pushNamed(context, MainScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Gagal Merubah Password, Coba Lagi Nanti"),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Gagal Merubah Password, Coba Lagi Nanti"),
        ));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Gagal Merubah Password, Coba Lagi Nanti"),
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      noCust = data['data']['user']['nocust'];
    }
    notifyListeners();
  }
}
