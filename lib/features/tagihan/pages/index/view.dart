import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class TagihanScreen extends StatelessWidget {
  static const String routeName = '/tagihan';
  final String virtualAccountNumber = "7510 0112 3456 7890";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TagihanController(),
      child: Consumer<TagihanController>(builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: BaseText.L(
              "Tagihan",
              color: PreferenceColors.yellow,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: PreferenceColors.purple,
            elevation: 0, // Removes shadow from the AppBar
            iconTheme: IconThemeData(
              color: PreferenceColors
                  .yellow, // Set back button icon color to white
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
                          "Total Tagihan",
                          fontWeight: FontWeight.w500,
                        ),
                        1.0.height,
                        BaseText(
                          text: "Rp80.000",
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.dp32,
                        ),
                        10.0.height,
                        BaseText.XS("Saldo utama kurang mohon isi saldo"),
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
                                      heightFactor:
                                          0.6, // Set the height to 70% of the screen
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
                                                fontWeight: FontWeight.bold),
                                            20.0.height,
                                            Container(
                                              width: Dimensions.width(context),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Dimensions.width(
                                                        context),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          Assets.BankMuamalat,
                                                          width:
                                                              Dimensions.width(
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
                                                                Clipboard
                                                                    .setData(
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
                                                                size: Dimensions
                                                                    .dp18,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      BaseText.S(
                                                          "1. Masuk ke akun rekening bank anda"),
                                                      BaseText.S(
                                                          "2. Pilih Transfer Lain"),
                                                      BaseText.S(
                                                          "3. Pilih menu Pembayaran kemudian pilih \n Virtual Account"),
                                                      BaseText.S(
                                                          "4. Masukan Nomor Virtual Account \n $virtualAccountNumber"),
                                                      BaseText.S(
                                                          "5. Tekan Bayar")
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
                                  BaseText.XS(
                                    "Isi  Saldo",
                                    color: PreferenceColors.purple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  BaseText.S("Riwayat", fontWeight: FontWeight.w600),
                  5.0.height,
                  HistorySection()
                ],
              ),
            ),
          ),
        );
      }),
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

class HistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
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
                      color: PreferenceColors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.cached_outlined,
                      size: Dimensions.dp20,
                      color: PreferenceColors.purple.shade400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("Pembayaran SPP", fontWeight: FontWeight.w600),
                      BaseText.XS("29 Mar 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
