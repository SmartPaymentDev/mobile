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
    try {
      String? username = await storage.read(key: 'username');
      if (username == null || username.isEmpty) {
        throw Exception('Username not found');
      }
      
      await Future.wait([
        fetchSppBalance(username),
        fetchSakuBalance(username),
        fetchBills(username),
        fetchPayments(username),
        fetchUser(),
      ]);
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> fetchSppBalance(String username) async {
    try {
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
        if (data != null && data['SALDO'] != null) {
          String saldoValue = data['SALDO'].toString();
          if (int.tryParse(saldoValue) != null) {
            sppBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                .format(int.parse(saldoValue));
            notifyListeners();
            return;
          }
        }
      }
      throw Exception('Invalid SPP balance data');
    } catch (e) {
      debugPrint('Error fetching SPP balance: $e');
      sppBalance = 'Rp0';
      notifyListeners();
    }
  }

  Future<void> fetchSakuBalance(String username) async {
    try {
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
        if (data != null && data['SALDO'] != null) {
          String saldoValue = data['SALDO'].toString();
          if (int.tryParse(saldoValue) != null) {
            sakuBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                .format(int.parse(saldoValue));
            notifyListeners();
            return;
          }
        }
      }
      throw Exception('Invalid saku balance data');
    } catch (e) {
      debugPrint('Error fetching saku balance: $e');
      sakuBalance = 'Rp0';
      notifyListeners();
    }
  }

  Future<void> fetchBills(String username) async {
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
        if (data != null && data['datas'] is List && data['datas'].isNotEmpty) {
          bill = data['datas'].first;
          notifyListeners();
          return;
        }
      }
      throw Exception('Invalid bills data');
    } catch (e) {
      debugPrint('Error fetching bills: $e');
      bill = {};
      notifyListeners();
    }
  }

  Future<void> fetchPayments(String username) async {
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
        final data = jsonDecode(response.body);
        if (data != null && data['datas'] is List && data['datas'].isNotEmpty) {
          payment = data['datas'].first;
          notifyListeners();
          return;
        }
      }
      throw Exception('Invalid payments data');
    } catch (e) {
      debugPrint('Error fetching payments: $e');
      payment = {};
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    try {
      final storedName = await storage.read(key: 'mahasiswa');
      final storedVa = await storage.read(key: 'nova');
      
      userName = storedName?.isNotEmpty == true ? storedName! : '...';
      noVa = storedVa?.isNotEmpty == true ? storedVa! : '...';
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      userName = '...';
      noVa = '...';
      notifyListeners();
    }
  }
}
