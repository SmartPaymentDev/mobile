import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/home/pages/index/controller.dart';
import 'package:ibnu_abbas/features/saku/saku.dart';
import 'package:ibnu_abbas/features/spp/spp.dart';
import 'package:ibnu_abbas/features/tagihan/tagihan.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(builder: (context, controller, child) {
        return Scaffold(
            body: LayoutContainer(
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
                  BalanceSection(),
                  15.0.height,
                  AccountSection(),
                  20.0.height,
                  BaseText.M("Layanan", fontWeight: FontWeight.w600),
                  10.0.height,
                  MenuSection(),
                  25.0.height,
                  BaseText.M("Tagihan", fontWeight: FontWeight.w600),
                  10.0.height,
                  BillSection(),
                ],
              )),
        ));
      }),
    );
  }
}

class GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Dimensions.width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BaseText.S("Assalamualaikum"),
          1.0.height,
          BaseText.L("Hasan",
              fontWeight: FontWeight.bold, color: PreferenceColors.purple),
        ],
      ),
    );
  }
}

class BalanceSection extends StatelessWidget {
  final String virtualAccountNumber =
      "7510 0112 3456 7890"; // Virtual account number

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreferenceColors.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText.XS("Saldo Saya",
                  fontWeight: FontWeight.w600, color: PreferenceColors.yellow),
              4.0.height,
              BaseText.XL("Rp100.000", color: PreferenceColors.white),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.6, // Set the height to 70% of the screen
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText.L("Top Up", fontWeight: FontWeight.w600),
                          20.0.height,
                          Container(
                            width: Dimensions.width(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Dimensions.width(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.BankMuamalat,
                                        width: Dimensions.width(context) / 2.5,
                                      ),
                                      15.0.height,
                                      BaseText.M(
                                        "Nomor Virtual Account",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      5.0.height,
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 10,
                                        children: [
                                          BaseText.XL(virtualAccountNumber),
                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                  text: virtualAccountNumber,
                                                ),
                                              );
                                              _showTopNotification(
                                                context,
                                                'Nomor Virtual Account di salin!',
                                              );
                                            },
                                            child: Icon(
                                              color: PreferenceColors
                                                  .black.shade300,
                                              Icons.copy,
                                              size: Dimensions.dp18,
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
                                      fontWeight: FontWeight.w600,
                                    ),
                                    BaseText.S(
                                        "1. Masuk ke akun rekening bank anda"),
                                    BaseText.S("2. Pilih Transfer Lain"),
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
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: PreferenceColors.white.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 32, color: PreferenceColors.yellow),
                  BaseText(
                      text: "Top Up",
                      color: PreferenceColors.purple,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimensions.dp10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTopNotification(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40, // Position from the top
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

    // Insert the overlay entry
    overlay.insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

class AccountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAccountItem(
          context,
          "SPP",
          "Rp80.000",
          "Utama",
          () => Navigator.pushNamed(context, SppScreen.routeName),
        ),
        _buildAccountItem(
          context,
          "Saku",
          "Rp20.000",
          "Tap untuk mengisi",
          () => Navigator.pushNamed(context, SakuScreen.routeName),
        ),
      ],
    );
  }

  Widget _buildAccountItem(
    BuildContext context,
    String title,
    String amount,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: PreferenceColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: PreferenceColors.black.shade100, width: 1),
        ),
        width: Dimensions.width(context) * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText.S(title),
            3.0.height,
            BaseText.L(amount, fontWeight: FontWeight.w600),
            1.0.height,
            BaseText(
              text: subtitle,
              fontSize: Dimensions.dp12,
              color: PreferenceColors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMenuItem(Icons.book, "Tahfidzh"),
        _buildMenuItem(Icons.school, "Akademik"),
        _buildMenuItem(Icons.diversity_1_rounded, "Akhlak"),
        _buildMenuItem(Icons.account_balance_wallet, "Keuangan"),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20), // Padding around the icon
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PreferenceColors
                .white.shade400, // Background color of the circle
          ),
          child: Icon(
            icon,
            size: 30,
            color: PreferenceColors.yellow,
          ),
        ),
        8.0.height,
        BaseText.XS(
          label,
          color: PreferenceColors.purple,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class BillSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 15,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PreferenceColors.purple.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.cached_outlined,
                  size: Dimensions.dp18,
                  color: PreferenceColors.purple.shade400,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText.L("Rp150.000", fontWeight: FontWeight.w500),
                  1.0.height,
                  BaseText.XS("Bayar sebelum 1 Feb 2024"),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the new screen when "Lihat Detil" is tapped
              Navigator.pushNamed(context, TagihanScreen.routeName);
            },
            child: BaseText.XS(
              "Lihat Detil",
              color: PreferenceColors.purple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
