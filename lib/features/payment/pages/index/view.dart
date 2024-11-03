import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/payment/pages/index/controller.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => PaymentcreenState();
}

class PaymentcreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaymentController>(context, listen: false).fetchPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BaseText.L(
          "Pembayaran",
          color: PreferenceColors.yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: PreferenceColors.purple,
        elevation: 0,
      ),
      body: Consumer<PaymentController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.payments.isEmpty) {
            return const Center(child: Text("No Payments available."));
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
                  itemCount: controller.payments.length,
                  itemBuilder: (context, index) {
                    final payment = controller.payments[index];

                    // Extracting payment details from the bill
                    final paymentDetails =
                        (payment['v_payment_details'] as List).map((detail) {
                      return {
                        "description": detail['nama_akun'],
                        "amount": detail['billam'].toString(),
                      };
                    }).toList();

                    return BillSection(
                      paidSt: payment['paidst'],
                      paiddt: payment['paiddt'],
                      month: payment['billnm'],
                      period: payment['bta'],
                      billDetails: paymentDetails,
                      total: payment['billam'].toString(),
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
