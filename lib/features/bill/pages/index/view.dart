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
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: controller.bills.length,
                  itemBuilder: (context, index) {
                    final bill = controller.bills[index];

                    final billDetails =
                        (bill['det'] as List).map((detail) {
                      return {
                        "description": detail['NamaPost'],
                        "amount": detail['DetailNominal'],
                      };
                    }).toList();

                    return BillSection(
                      paidSt: '0',
                      paiddt: '',
                      KodeBayar: bill['KodeBayar'],
                      month: bill['NamaTagihan'],
                      period: bill['TahunAkademik'],
                      billDetails: billDetails,
                      total: bill['TotalNominal'].toString(),
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
