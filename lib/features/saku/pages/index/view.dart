import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class SakuScreen extends StatefulWidget {
  const SakuScreen({super.key});
  static const String routeName = '/saku';

  @override
  State<SakuScreen> createState() => _SakuScreenState();
}

class _SakuScreenState extends State<SakuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SakuController>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SakuController>(context);
    final virtualAccountNumber = controller.virtualAccountNumber;
    final TextEditingController _amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: BaseText.L(
          "Saku",
          color: PreferenceColors.yellow,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: PreferenceColors.purple,
        elevation: 0,
        iconTheme: IconThemeData(
          color: PreferenceColors.yellow,
        ),
      ),
      body: LayoutContainer(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width(context) / 25,
          ),
          width: Dimensions.width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height(context) / 2.8,
                width: Dimensions.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText.S(
                      "SALDO SAAT INI",
                      fontWeight: FontWeight.w500,
                    ),
                    5.0.height,
                    BaseText(
                      text: controller.sakuBalance,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.dp32,
                    ),
                    25.0.height,
                    Wrap(
                      spacing: 35,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return TopUpBottomSheet(
                                  amountController: _amountController,
                                );
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: PreferenceColors.white.shade400,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 32,
                                  color: PreferenceColors.yellow,
                                ),
                              ),
                              6.0.height,
                              BaseText.S(
                                "Top Up",
                                color: PreferenceColors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              BaseText.M("Riwayat", fontWeight: FontWeight.w600),
              Container(
                height:
                    Dimensions.height(context) * 0.6, // 50% of screen height
                child: SingleChildScrollView(
                  child: HistorySection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}

class HistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SakuController>(context);
    return Wrap(
      direction: Axis.vertical,
      children: [
        Container(
          width: Dimensions.width(context) / 1.1,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: PreferenceColors.white.shade600,
                width: 1.0,
              ),
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.history.length,
            itemBuilder: (context, index) {
              final history = controller.history[index];
              double amount = history['debet'] != 0
                  ? history['debet'].toDouble()
                  : history['kredit'].toDouble();
              return Container(
                width: Dimensions.width(context) / 1.1,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: PreferenceColors.white.shade600,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 15,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: history['kredit'] != 0
                                ? PreferenceColors.green.shade100
                                : PreferenceColors.red.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            history['kredit'] != 0
                                ? Icons.south_east
                                : Icons.north_west,
                            size: Dimensions.dp20,
                            color: history['kredit'] != 0
                                ? PreferenceColors.green
                                : PreferenceColors.red,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText.M(history['metode'],
                                fontWeight: FontWeight.w600),
                            BaseText.XS(history['trxdate']),
                          ],
                        ),
                      ],
                    ),
                    BaseText.M(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
                          .format(amount),
                      fontWeight: FontWeight.w600,
                      color: history['kredit'] != 0
                          ? PreferenceColors.green
                          : PreferenceColors.red,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopUpBottomSheet extends StatelessWidget {
  final TextEditingController amountController;

  const TopUpBottomSheet({
    Key? key,
    required this.amountController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SakuController>(context);

    return FractionallySizedBox(
      heightFactor: 0.35,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText.L("Top Up", fontWeight: FontWeight.w600),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseInput.underlined(
                    controller: amountController,
                    labelText: "Nominal",
                  ),
                  20.0.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText.M("Saldo SPP"),
                      BaseText.M(
                        controller.sppBalance,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () async {
                final success = await controller.topup(
                  context,
                  amountController.text,
                );
                if (success) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: PreferenceColors.purple,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: controller.isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: PreferenceColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : BaseText.M(
                          "Konfirmasi",
                          color: PreferenceColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
