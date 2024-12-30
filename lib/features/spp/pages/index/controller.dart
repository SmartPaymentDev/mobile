import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ibnu_abbas/api.dart';
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class SppController extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String sppBalance = 'Rp0';
  List<dynamic> history = [];
  String virtualAccountNumber = "-";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    String? username = await storage.read(key: 'username');
    await fetchSppBalance(username);
    await fetchUser();
  }

  Future<bool> transfer(
      BuildContext context, String amount) async {
    if (amount.isEmpty || amount == '0') {
      _showTopNotification(context, "Nominal Wajib Di Isi.");
      return false;
    }
    if (_isLoading) return false;
    _isLoading = true;
    notifyListeners();
    String? username = await storage.read(key: 'username');
    try {
      final claimSet = JwtClaim(
        otherClaims: <String, dynamic>{
          'USERNAME': username,
          'NOMINAL': amount,
          'METHOD': 'PaymentExeCashless',
        },
      );
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data[0]['STATUS'] == 'OK') {
          await fetchData();
          await fetchSppHistory();
          return true;
        }
        _showTopNotification(context, data[0]['PesanRespon']);
        return false;
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
      final saldoValue = data['SALDO'];
      sppBalance = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(int.parse(saldoValue));
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

  Future<void> fetchSppHistory() async {
    String? username = await storage.read(key: 'username');

    try {
      final claimSet = JwtClaim(
        otherClaims: <String, dynamic>{
          'USERNAME': username,
          'METHOD': 'TransaksiRequest'
        },
      );
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        history = data['datas'] ?? [];
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

  Future<void> fetchUser() async {
    virtualAccountNumber = await storage.read(key: 'nova') ?? '...';
    notifyListeners();
  }
}
