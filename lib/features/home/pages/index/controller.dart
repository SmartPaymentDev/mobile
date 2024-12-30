import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ibnu_abbas/api.dart';
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class HomeController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  String sppBalance = 'Rp0';
  String sakuBalance = 'Rp0';
  String userName = '...';
  String noVa = '...';

  Map<String, dynamic> bill = {};
  Map<String, dynamic> payment = {};

  Future<void> fetchData() async {
    String? username = await storage.read(key: 'username');
    await fetchSppBalance(username);
    await fetchSakuBalance(username);
    await fetchBills(username);
    await fetchPayments(username);
    await fetchUser();
  }

  Future<void> fetchSppBalance(String? username) async {
    final claimSet = JwtClaim(
      otherClaims: <String, dynamic>{
        'USERNAME': username,
        'METHOD': 'SaldoRequest',
      },
    );
    final token = issueJwtHS256(claimSet, keyJwt);
    final response = await http.get(
      Uri.parse('$apiBase$token'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String saldoValue = data['SALDO'];
      sppBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(int.parse(saldoValue));
    } else {
      sppBalance = 'Rp0';
    }
    notifyListeners();
  }

  Future<void> fetchSakuBalance(String? username) async {
    final claimSet = JwtClaim(
      otherClaims: <String, dynamic>{
        'USERNAME': username,
        'METHOD': 'SaldoRequestSaku',
      },
    );
    final token = issueJwtHS256(claimSet, keyJwt);
    final response = await http.get(
      Uri.parse('$apiBase$token'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String saldoValue =
          data['SALDO'];
      sakuBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(int.parse(saldoValue));
    } else {
      sakuBalance = 'Rp0';
    }
    notifyListeners();
  }

  Future<void> fetchBills(String? username) async {
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
      bill = data['datas']?.first ?? {};
    }
    notifyListeners();
  }

  Future<void> fetchPayments(String? username) async {
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
      final data = jsonDecode(response.body);
      payment = data['datas']?.first ?? {};
    }
    notifyListeners();
  }

  Future<void> fetchUser() async {
    userName = await storage.read(key: 'mahasiswa') ?? '...';
    noVa = await storage.read(key: 'nova') ?? '...';
    notifyListeners();
  }
}
