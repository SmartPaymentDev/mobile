import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ibnu_abbas/api.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:ibnu_abbas/core/core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart'; // Import http package for API call

class BillSection extends StatelessWidget {
  final String month;
  final String period;
  final List<dynamic>? billDetails;
  final String total;
  String paidSt;
  final String paiddt;
  final String KodeBayar;

  BillSection({
    Key? key,
    required this.month,
    required this.period,
    required this.billDetails,
    required this.total,
    required this.paidSt,
    required this.paiddt,
    required this.KodeBayar,
  }) : super(key: key);

  String formatCurrency(String amount) {
    try {
      final doubleValue = double.parse(amount);
      final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
      return formatter.format(doubleValue);
    } catch (e) {
      return amount;
    }
  }

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> _makePayment(BuildContext context) async {
    String? username = await storage.read(key: 'username');

    final claimSet = JwtClaim(
      otherClaims: <String, dynamic>{
        'USERNAME': username,
        'KodeBayar': KodeBayar,
        'METHOD': 'PaymentExe',
      },
    );

    try {
      final token = issueJwtHS256(claimSet, keyJwt);
      final response = await http.get(
        Uri.parse('$apiBase$token'),
      );
      final data = jsonDecode(response.body);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        if (data[0]['STATUS'] == 'OK') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pembayaran berhasil')),
          );
          paidSt = '1';
          Navigator.of(context).pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data[0]['PesanRespon'])),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin membayar tagihan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            BaseButton.primary(
              text: "Bayar",
              onPressed: () async {
                Navigator.of(context).pop(); // Close the confirmation dialog
                await _makePayment(context); // Call API
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreferenceColors.white,
        border: Border(
            bottom:
                BorderSide(color: PreferenceColors.white.shade700, width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.dp14), // Add padding inside the container
      margin: const EdgeInsets.symmetric(
          vertical: 8), // Add margin between sections
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText.M(month, fontWeight: FontWeight.w600), // Display month
              BaseText.M(period), // Display period
            ],
          ),
          const SizedBox(height: 5),
          Divider(color: PreferenceColors.black.shade100, thickness: 1),
          if (paidSt == '1') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText.M("TGL BAYAR", fontWeight: FontWeight.w600),
                BaseText.M(paiddt),
              ],
            ),
            Divider(color: PreferenceColors.black.shade100, thickness: 1),
          ],
          const SizedBox(height: 5),
          BaseText.XS(
            "Detail Tagihan",
            color: PreferenceColors.black.shade600,
          ),
          const SizedBox(height: 5),
          ...(billDetails ?? []).map((bill) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText.M(bill['description'] ?? ''),
                    BaseText.M(bill['amount']),
                  ],
                ),
              )),
          const SizedBox(height: 5),
          Divider(color: PreferenceColors.black.shade100, thickness: 1),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText.XS(
                    "Total",
                    color: PreferenceColors.black.shade600,
                  ),
                  const SizedBox(height: 5),
                  BaseText.L(
                    formatCurrency(total), // Format total
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              if (paidSt == '1') ...[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      size: 25,
                      color: PreferenceColors.green,
                    ),
                    BaseText.L(
                      "Lunas",
                      color: PreferenceColors.green,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ],
              if (paidSt == '0') ...[
                BaseButton.primary(
                  text: "Bayar",
                  onPressed: () => _showConfirmationDialog(context),
                )
              ],
            ],
          ),
        ],
      ),
    );
  }
}
