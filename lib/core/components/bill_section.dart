import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:ibnu_abbas/core/core.dart';

class BillSection extends StatelessWidget {
  final String month;
  final String period;
  final List<dynamic>? billDetails;
  final String total;
  final String paidSt;
  final String paiddt;

  const BillSection({
    Key? key,
    required this.month,
    required this.period,
    required this.billDetails,
    required this.total,
    required this.paidSt,
    required this.paiddt,
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
                    BaseText.M(formatCurrency(bill['amount'] ?? '0')),
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
                )
              ]
            ],
          )
        ],
      ),
    );
  }
}
