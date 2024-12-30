import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/home/pages/index/controller.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:ibnu_abbas/features/main/pages/index/controller.dart';
import 'package:ibnu_abbas/features/saku/saku.dart';
import 'package:ibnu_abbas/features/spp/spp.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    try {
      await Provider.of<HomeController>(context, listen: false).fetchData();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    final bill = controller.bill;
    final billDetails = bill.isNotEmpty
        ? (bill['det'] as List).map((detail) {
            return {
              "description": detail['NamaPost'],
              "amount": detail['DetailNominal'],
            };
          }).toList()
        : [];
    final payment = controller.payment;
    final paymentDetail = payment.isNotEmpty
        ? (bill['det'] as List).map((detail) {
            return {
              "description": detail['NamaPost'],
              "amount": detail['DetailNominal'],
            };
          }).toList()
        : [];

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _fetchData,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width(context) * 0.05),
            width: Dimensions.width(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingSection(),
                10.0.height,
                SppSection(),
                15.0.height,
                SakuSection(),
                30.0.height,
                BaseText.M("Menu", fontWeight: FontWeight.w600),
                15.0.height,
                MenuSection(),
                30.0.height,
                if (bill.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText.M("Tagihan", fontWeight: FontWeight.w600),
                      GestureDetector(
                        onTap: () {
                          Provider.of<MainScreenController>(context,
                                  listen: false)
                              .setSelectedIndex(1);
                          Navigator.pushNamed(context, MainScreen.routeName);
                        },
                        child: BaseText.S(
                          "Lihat Semua",
                          fontWeight: FontWeight.w600,
                          color: PreferenceColors.purple,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      BillSection(
                        paidSt: '0',
                        paiddt: '',
                        KodeBayar: bill['KodeBayar'],
                        month: bill['NamaTagihan'],
                        period: bill['TahunAkademik'],
                        billDetails: billDetails,
                        total: bill['TotalNominal'].toString(),
                      )
                    ],
                  ),
                ],
                if (payment.isNotEmpty) ...[
                  25.0.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText.M("Pambayaran Terakhir",
                          fontWeight: FontWeight.w600),
                      GestureDetector(
                        onTap: () {
                          Provider.of<MainScreenController>(context,
                                  listen: false)
                              .setSelectedIndex(2);
                          Navigator.pushNamed(context, MainScreen.routeName);
                        },
                        child: BaseText.S(
                          "Lihat Semua",
                          fontWeight: FontWeight.w600,
                          color: PreferenceColors.purple,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      BillSection(
                        paidSt: '1',
                        paiddt: payment['TanggalBayar'],
                        KodeBayar: bill['KodeBayar'],
                        month: payment['NamaTagihan'],
                        period: payment['TahunAkademik'],
                        billDetails: paymentDetail,
                        total: payment['TotalNominal'].toString(),
                      )
                    ],
                  ),
                ],
                15.0.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return Container(
      height: 100,
      width: Dimensions.width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BaseText.S("Assalamualaikum"),
          1.0.height,
          BaseText.L(controller.userName,
              fontWeight: FontWeight.bold, color: PreferenceColors.purple),
        ],
      ),
    );
  }
}

class SppSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return Container(
      decoration: BoxDecoration(
        color: PreferenceColors.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText.S("Saldo SPP",
                    fontWeight: FontWeight.w600,
                    color: PreferenceColors.yellow),
                6.0.height,
                Row(
                  children: [
                    BaseText.S(controller.noVa, color: PreferenceColors.white),
                    8.0.width,
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: controller.noVa));
                        _showTopNotification(
                            context, "Nomor Virtual Account berhasil disalin");
                      },
                      child: Icon(
                        Icons.copy,
                        color: PreferenceColors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BaseText.M(
              controller.sppBalance,
              color: PreferenceColors.white,
              fontWeight: FontWeight.w600,
            )
          ]),
          5.0.height,
          BaseButton.secondary(
            text: "Transaksi",
            onPressed: () => Navigator.pushNamed(context, SppScreen.routeName),
            width: Dimensions.width(context),
          )
        ],
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

class SakuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return Container(
      decoration: BoxDecoration(
        color: PreferenceColors.yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: PreferenceColors.black.shade100,
          width: 1.5,
        ),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText.S("Saldo Saku",
                    fontWeight: FontWeight.w600,
                    color: PreferenceColors.purple),
                5.0.height,
                Row(
                  children: [
                    BaseText.S(controller.noVa, color: PreferenceColors.black),
                    8.0.width,
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: controller.noVa));
                        _showTopNotification(
                            context, "Nomor Virtual Account berhasil disalin");
                      },
                      child: Icon(
                        Icons.copy,
                        color: PreferenceColors.purple,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BaseText.M(
              controller.sakuBalance,
              color: PreferenceColors.purple,
              fontWeight: FontWeight.w600,
            )
          ]),
          5.0.height,
          BaseButton.primary(
            text: "Transaksi",
            onPressed: () => Navigator.pushNamed(context, SakuScreen.routeName),
            width: Dimensions.width(context),
          )
        ],
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

class MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: Dimensions.dp18,
        runSpacing: Dimensions.dp18,
        children: [
          _buildMenuItem(Icons.book, "Tahfidzh", context),
          _buildMenuItem(Icons.school, "Akademik", context),
          _buildMenuItem(Icons.diversity_1_rounded, "Akhlak", context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, BuildContext context) {
    return Container(
      width: Dimensions.width(context) * 0.20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: PreferenceColors.white.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 35,
                  color: PreferenceColors.yellow,
                ),
              ),
              10.0.height,
              BaseText.S(
                label,
                color: PreferenceColors.purple,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
