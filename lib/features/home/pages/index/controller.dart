import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  String sppBalance = 'Rp0';
  String sakuBalance = 'Rp0';
  String userName = '...';
  String noCust = '...';

  Map<String, dynamic> bill = {};
  Map<String, dynamic> payment = {};

  Future<void> fetchData() async {
    String? authToken = await storage.read(key: 'authToken');
    await fetchSppBalance(authToken);
    await fetchSakuBalance(authToken);
    await fetchBills(authToken);
    await fetchPayments(authToken);
    await fetchUser(authToken);
  }

  Future<void> fetchSppBalance(String? authToken) async {
    final response = await http.get(
      Uri.parse('http://18.141.174.182/spp/balance'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double saldoValue = data['data']['v_saldo_va']['saldo'].toDouble();
      sppBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(saldoValue);
    } else {
      sppBalance = 'Rp0';
    }
    notifyListeners();
  }

  Future<void> fetchSakuBalance(String? authToken) async {
    final response = await http.get(
      Uri.parse('http://18.141.174.182/saku/balance'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double saldoValue =
          data['data']['v_saldo_va_cashless']['saldo'].toDouble();
      sakuBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(saldoValue);
    } else {
      sakuBalance = 'Rp0';
    }
    notifyListeners();
  }

  Future<void> fetchBills(String? authToken) async {
    final now = DateTime.now();
    final yearMonth = DateFormat('yyyyMM').format(now);

    final response = await http.get(
      Uri.parse('http://18.141.174.182/bills?paid_st=0&yearmonth=$yearMonth'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      bill = data['data']['bills']?.first ?? {};
    }
    notifyListeners();
  }

  Future<void> fetchPayments(String? authToken) async {
    final response = await http.get(
      Uri.parse('http://18.141.174.182/bills?paid_st=1'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      payment = data['data']['bills']?.first ?? {};
    }
    notifyListeners();
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
    }
    notifyListeners();
  }
}
