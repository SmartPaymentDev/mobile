import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/account/pages/index/controller.dart';
import 'package:ibnu_abbas/features/auth/auth.dart';
import 'package:ibnu_abbas/features/reset-pass/pages/index/view.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final String virtualAccountNumber = "7510 0112 3456 7890";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountController(),
      child: Consumer<AccountController>(builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BaseText.L(
              "Profil",
              color: PreferenceColors.yellow,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: PreferenceColors.purple,
            elevation: 0,
          ),
          body: LayoutContainer(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height(context) / 60,
                horizontal: Dimensions.width(context) / 25,
              ),
              width: Dimensions.width(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: PreferenceColors.purple,
                        child: BaseText.L(
                          'H', // First letter of the user's name
                          color: PreferenceColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.0.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText.L(
                            'Hasan', // User name
                            fontWeight: FontWeight.w500,
                          ),
                          1.0.height,
                          BaseText.S("Kelompok A")
                        ],
                      )
                    ],
                  ),
                  20.0.height,
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PreferenceColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: PreferenceColors.black.shade100, width: 1),
                    ),
                    width: Dimensions.width(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText.S("No. VA SPP"),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            BaseText.M("7510 0112 3456 7890",
                                fontWeight: FontWeight.w600),
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
                                color: PreferenceColors.black.shade300,
                                Icons.copy,
                                size: Dimensions.dp18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  15.0.height,
                  Container(
                      width: Dimensions.width(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: PreferenceColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: PreferenceColors.black.shade100,
                                  width: 1),
                            ),
                            width: Dimensions.width(context) / 2.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText.M("Jenjang"),
                                3.0.height,
                                BaseText.M("SMA", fontWeight: FontWeight.w600),
                                1.0.height,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: PreferenceColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: PreferenceColors.black.shade100,
                                  width: 1),
                            ),
                            width: Dimensions.width(context) / 2.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText.M("Kelas"),
                                3.0.height,
                                BaseText.M("1", fontWeight: FontWeight.w600),
                                1.0.height,
                              ],
                            ),
                          ),
                        ],
                      )),
                  20.0.height,
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, ResetPassScreen.routeName)
                    },
                    child: Container(
                      height: Dimensions.dp48,
                      width: Dimensions.width(context),
                      decoration: BoxDecoration(
                        color: PreferenceColors.purple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: BaseText.M(
                          "Ganti Password",
                          color: PreferenceColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  10.0.height,
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, AuthLoginScreen.routeName)
                    },
                    child: Container(
                      height: Dimensions.dp48,
                      width: Dimensions.width(context),
                      decoration: BoxDecoration(
                        color: PreferenceColors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: BaseText.M(
                          "Keluar",
                          color: PreferenceColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  10.0.height,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
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
