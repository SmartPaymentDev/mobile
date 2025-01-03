import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class SppController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String sppBalance = 'Rp0';
  List<dynamic> history = [];
  String virtualAccountNumber = "-";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    String? authToken = await storage.read(key: 'authToken');
    await fetchSppBalance(authToken);
    await fetchUser(authToken);
  }

  Future<bool> transfer(
      BuildContext context, String amount, String destination) async {
    if (amount.isEmpty && destination.isEmpty) {
      _showTopNotification(context, "Mohon Lengkapi Semua Input.");
      return false;
    }
    if (_isLoading) return false;
    _isLoading = true;
    notifyListeners();
    String? authToken = await storage.read(key: 'authToken');
    try {
      final response = await http.post(
        Uri.parse('http://18.141.174.182/$destination'),
        body: json.encode({'amount': int.parse(amount)}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      if (response.statusCode == 200) {
        await fetchData();
        DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
        DateTime _endDate = DateTime.now();
        await fetchSppHistory(startDate: _startDate, endDate: _endDate);
        return true;
      } else {
        _showTopNotification(context, "Transfer Gagal, Harap Coba Lagi Nanti");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      _showTopNotification(context, "Transfer Gagal, Harap Coba Lagi Nanti");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

  void _showTopNotification(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black87,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  Future<void> fetchSppHistory({DateTime? startDate, DateTime? endDate}) async {
    String? authToken = await storage.read(key: 'authToken');

    final String? fromDate = startDate?.toIso8601String().split('T')[0];
    final String? toDate = endDate?.toIso8601String().split('T')[0];

    final Uri uri = Uri.parse('http://18.141.174.182/spp').replace(
      queryParameters: {
        if (fromDate != null) 'from': fromDate,
        if (toDate != null) 'to': toDate,
        'per_page' : '1000',
        'page' : '1',
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        history = data['data']['transactions'] ?? [];
      } else {
        history = [];
      }
    } catch (e) {
      print('Error fetching SPP history: $e');
      history = [];
    } finally {
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
      virtualAccountNumber = data['data']['user']['no_va'];
    }
    notifyListeners();
  }
}
