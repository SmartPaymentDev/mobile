import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class SakuScreen extends StatelessWidget {
  static const String routeName = '/saku';
  final String virtualAccountNumber = "7510 0112 3456 7890";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SakuController(),
      child: Consumer<SakuController>(builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: BaseText.L(
              "Saku",
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
                          "SALDO SAAT INI",
                          fontWeight: FontWeight.w500,
                        ),
                        1.0.height,
                        BaseText(
                          text: "Rp20.000",
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.dp32,
                        ),
                        25.0.height,
                        Wrap(
                          spacing: 35,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return FractionallySizedBox(
                                      heightFactor: 0.38,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            width: Dimensions.width(context),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BaseText.L("Tambah",
                                                    fontWeight:
                                                        FontWeight.w600),
                                                20.0.height,
                                                Container(
                                                  width:
                                                      Dimensions.width(context),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      BaseInput.underlined(
                                                          labelText:
                                                              "Masukan Nominal"),
                                                      20.0.height,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          BaseText.M(
                                                              "Saldo SPP"),
                                                          BaseText.M(
                                                            "Rp.300.000",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                30.0.height,
                                                GestureDetector(
                                                  onTap: () {
                                                    // Close the bottom sheet
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: Dimensions.dp48,
                                                    width: Dimensions.width(
                                                        context),
                                                    decoration: BoxDecoration(
                                                      color: PreferenceColors
                                                          .purple,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: BaseText.M(
                                                        "Tambah Uang",
                                                        color: PreferenceColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                    "Top Up",
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
                  BaseText.M("Riwayat", fontWeight: FontWeight.w600),
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
                      color: PreferenceColors.green.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.south_east,
                      size: Dimensions.dp20,
                      color: PreferenceColors.green,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("CASHLESS 1 VA", fontWeight: FontWeight.w600),
                      BaseText.XS("OCT 4, 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "+150.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.green,
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
                      color: PreferenceColors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.north_west,
                      size: Dimensions.dp20,
                      color: PreferenceColors.red,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.M("CASHLESS 1 VA", fontWeight: FontWeight.w600),
                      BaseText.XS("OCT 4, 2024"),
                    ],
                  ),
                ],
              ),
              BaseText.M(
                "-80.000",
                fontWeight: FontWeight.w600,
                color: PreferenceColors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
