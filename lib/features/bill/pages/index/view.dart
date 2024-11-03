import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/bill/pages/index/controller.dart';
import 'package:provider/provider.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => BillScreenState();
}

class BillScreenState extends State<BillScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BillController>(context, listen: false).fetchBills();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BaseText.L(
          "Tagihan",
          color: PreferenceColors.yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: PreferenceColors.purple,
        elevation: 0,
      ),
      body: Consumer<BillController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.bills.isEmpty) {
            return const Center(child: Text("No bills available."));
          }

          return LayoutContainer(
              child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width(context) / 25,
            ),
            width: Dimensions.width(context),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true, // Add this line
                  physics:
                      const NeverScrollableScrollPhysics(), // Add this line
                  itemCount: controller.bills.length,
                  itemBuilder: (context, index) {
                    final bill = controller.bills[index];

                    // Extracting payment details from the bill
                    final billDetails =
                        (bill['v_payment_details'] as List).map((detail) {
                      return {
                        "description": detail['nama_akun'],
                        "amount": detail['billam'].toString(),
                      };
                    }).toList();

                    return BillSection(
                      paidSt: bill['paidst'],
                      paiddt: bill['paiddt'],
                      month: bill['billnm'],
                      period: bill['bta'],
                      billDetails: billDetails,
                      total: bill['billam'].toString(),
                    );
                  },
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
