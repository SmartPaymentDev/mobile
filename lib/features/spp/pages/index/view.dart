import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class SppScreen extends StatefulWidget {
  const SppScreen({super.key});
  static const String routeName = '/spp';

  @override
  State<SppScreen> createState() => _SppScreenState();
}

class _SppScreenState extends State<SppScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SppController>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SppController>(context);
    final virtualAccountNumber = controller.virtualAccountNumber;
    final TextEditingController _amountController = TextEditingController();
    final TextEditingController _destinationController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: BaseText.L(
          "SPP",
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
                      text: controller.sppBalance,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.dp32,
                    ),
                    25.0.height,
                    Wrap(
                      spacing: 35,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.65,
                                  child: Container(
                                    width: Dimensions.width(context),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BaseText.L("Top Up",
                                            fontWeight: FontWeight.w600),
                                        20.0.height,
                                        Container(
                                          width: Dimensions.width(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    Dimensions.width(context),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      Assets.BankMuamalat,
                                                      width: Dimensions.width(
                                                              context) /
                                                          2.5,
                                                    ),
                                                    15.0.height,
                                                    BaseText.M(
                                                      "Nomor Virtual Account",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    5.0.height,
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      spacing: 10,
                                                      children: [
                                                        BaseText.XL(
                                                            virtualAccountNumber),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Clipboard.setData(
                                                              ClipboardData(
                                                                text:
                                                                    virtualAccountNumber,
                                                              ),
                                                            );
                                                            _showTopNotification(
                                                              context,
                                                              'Nomor Virtual Account di salin!',
                                                            );
                                                          },
                                                          child: Icon(
                                                            color:
                                                                PreferenceColors
                                                                    .black
                                                                    .shade300,
                                                            Icons.copy,
                                                            size:
                                                                Dimensions.dp18,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              20.0.height,
                                              Wrap(
                                                direction: Axis.vertical,
                                                spacing: 8,
                                                children: [
                                                  BaseText.M(
                                                    "Petunjuk",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  BaseText.S(
                                                      "1. Masuk ke akun rekening bank anda"),
                                                  BaseText.S(
                                                      "2. Pilih Transfer Lain"),
                                                  BaseText.S(
                                                      "3. Pilih menu Pembayaran kemudian pilih \n Virtual Account"),
                                                  BaseText.S(
                                                      "4. Masukan Nomor Virtual Account \n $virtualAccountNumber"),
                                                  BaseText.S("5. Tekan Bayar")
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                    14), // Padding around the icon
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: PreferenceColors.white
                                      .shade400, // Background color of the circle
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
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return TransferBottomSheet(
                                    amountController: _amountController,
                                    destinationController:
                                        _destinationController);
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
                                  Icons.arrow_upward,
                                  size: 32,
                                  color: PreferenceColors.yellow,
                                ),
                              ),
                              6.0.height,
                              BaseText.S(
                                "Pindahkan",
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
              HistorySection(),
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
      Provider.of<SppController>(context, listen: false)
          .fetchSppHistory(startDate: _startDate, endDate: _endDate);
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
      final controller = Provider.of<SppController>(context, listen: false);
      controller.fetchSppHistory(startDate: _startDate, endDate: _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SppController>(context);

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
                  final amount = history['DEBET'] != '0'
                      ? int.parse(history['DEBET'])
                      : int.parse(history['KREDIT']);
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
                                color: history['KREDIT'] != '0'
                                    ? PreferenceColors.green.shade100
                                    : PreferenceColors.red.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                history['KREDIT'] != '0'
                                    ? Icons.south_east
                                    : Icons.north_west,
                                size: Dimensions.dp20,
                                color: history['KREDIT'] != '0'
                                    ? PreferenceColors.green
                                    : PreferenceColors.red,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText.M(history['KETERANGAN'],
                                    fontWeight: FontWeight.w600),
                                BaseText.XS(history['TGL']),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BaseText.M(
                              (history['KREDIT'] != '0' ? '+' : '-') +
                                  NumberFormat.currency(
                                          locale: 'id_ID', symbol: 'Rp')
                                      .format(amount),
                              fontWeight: FontWeight.w600,
                              color: history['KREDIT'] != '0'
                                  ? PreferenceColors.green
                                  : PreferenceColors.red,
                            ),
                            BaseText.XS(
                              history['KREDIT'] != '0' ? 'Kredit' : 'Debet',
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

String formatCurrency(dynamic number) {
  if (number is int) {
    return NumberFormat().format(number).replaceAll(',', '.');
  } else if (number is double) {
    return NumberFormat()
        .format(number)
        .replaceAll(',', 'X')
        .replaceAll('.', ',')
        .replaceAll('X', '.');
  } else {
    return '0';
  }
}

class TransferBottomSheet extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController destinationController;

  const TransferBottomSheet({
    Key? key,
    required this.amountController,
    required this.destinationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SppController>(context);
    final viewInsets = MediaQuery.of(context).viewInsets;
    final screenHeight = MediaQuery.of(context).size.height;

    int amount = 0;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.85,
          minHeight: screenHeight * 0.45,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: BaseText.L("Pindahkan", fontWeight: FontWeight.w600),
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
                              onChanged: (newValue) {
                                String value = newValue
                                    .replaceAll(',', '')
                                    .replaceAll('.', '');
                                int valueNow = int.tryParse(value) ?? 0;
                                amountController.text =
                                    formatCurrency(valueNow);
                                amount = valueNow;
                              },
                            ),
                            SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Tujuan",
                                contentPadding: const EdgeInsets.all(14),
                                border: UnderlineInputBorder(),
                              ),
                              value: destinationController.text.isEmpty
                                  ? null
                                  : destinationController.text,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'saku',
                                  child: Text('Kantong Saku'),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  destinationController.text = newValue;
                                }
                              },
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
                  final success = await controller.transfer(
                    context,
                    amount.toString(),
                    destinationController.text,
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
