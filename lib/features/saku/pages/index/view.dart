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
              HistorySection()
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

class HistorySection extends StatefulWidget {
  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SakuController>(context, listen: false)
          .fetchSakuHistory(startDate: _startDate, endDate: _endDate);
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: PreferenceColors.purple,
              onPrimary: PreferenceColors.yellow,
              surface: PreferenceColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      final controller = Provider.of<SakuController>(context, listen: false);
      controller.fetchSakuHistory(startDate: _startDate, endDate: _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SakuController>(context);

    return Wrap(
      direction: Axis.vertical,
      children: [
        Container(
          width: Dimensions.width(context) / 1.1,
          margin: EdgeInsets.only(top: 10, bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PreferenceColors.white.shade600,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText.S(
                          "${DateFormat('dd MMM yyyy').format(_startDate)}",
                          color: PreferenceColors.black.shade600,
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: Dimensions.dp16,
                          color: PreferenceColors.black.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              7.0.width,
              BaseText.S("s/d"),
              7.0.width,
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PreferenceColors.white.shade600,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText.S(
                          "${DateFormat('dd MMM yyyy').format(_endDate)}",
                          color: PreferenceColors.black.shade600,
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: Dimensions.dp16,
                          color: PreferenceColors.black.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: Dimensions.height(context) * 0.45,
          child: SingleChildScrollView(
            child: Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BaseText.M(
                              (history['kredit'] != 0 ? '+' : '-') +
                                  NumberFormat.currency(
                                          locale: 'id_ID', symbol: 'Rp')
                                      .format(amount),
                              fontWeight: FontWeight.w600,
                              color: history['kredit'] != 0
                                  ? PreferenceColors.green
                                  : PreferenceColors.red,
                            ),
                            BaseText.XS(
                              history['kredit'] != 0 ? 'Kredit' : 'Debet',
                              color: PreferenceColors.black.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
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
    final viewInsets = MediaQuery.of(context).viewInsets;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.85,
          minHeight: screenHeight * 0.40,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: BaseText.L("Top Up", fontWeight: FontWeight.w600),
            ),

            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseInput.underlined(
                              controller: amountController,
                              labelText: "Nominal",
                              keyboardType:
                                  TextInputType.number, 
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  String numericValue =
                                      value.replaceAll(RegExp(r'[^0-9]'), '');

                                  final format = NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  );

                                  amountController.value = TextEditingValue(
                                    text:
                                        format.format(int.parse(numericValue)),
                                    selection: TextSelection.collapsed(
                                      offset: format
                                          .format(int.parse(numericValue))
                                          .length,
                                    ),
                                  );
                                }
                              },
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: BaseButton.primary(
                width: double.infinity,
                text: "Konfirmasi",
                onPressed: () async {
                  final success = await controller.topup(
                    context,
                    amountController.text,
                  );
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                isLoading: controller.isLoading,
              ),
            )
          ],
        ),
      ),
    );
  }
}