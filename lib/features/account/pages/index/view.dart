import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/account/pages/index/controller.dart';
import 'package:ibnu_abbas/features/reset-pass/pages/index/view.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AccountController>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AccountController>(context);
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
                      controller.mahasiswa
                          .split(' ')
                          .map((word) =>
                              word.isNotEmpty ? word[0].toUpperCase() : '')
                          .join(''),
                      color: PreferenceColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.0.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText.L(
                        controller.mahasiswa,
                        fontWeight: FontWeight.w500,
                      ),
                      1.0.height,
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: [
                          BaseText.M(controller.nova,
                              fontWeight: FontWeight.w600),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: controller.nova,
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
                    BaseText.M("Jenjang"),
                    BaseText.M(
                      controller.jenjang,
                      fontWeight: FontWeight.w600,
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
                              color: PreferenceColors.black.shade100, width: 1),
                        ),
                        width: Dimensions.width(context) / 2.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText.M("Kelas"),
                            3.0.height,
                            BaseText.M(controller.kelas,
                                fontWeight: FontWeight.w600),
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
                              color: PreferenceColors.black.shade100, width: 1),
                        ),
                        width: Dimensions.width(context) / 2.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText.M("Kelompok"),
                            3.0.height,
                            BaseText.M(controller.kelompok,
                                fontWeight: FontWeight.w600),
                            1.0.height,
                          ],
                        ),
                      ),
                    ],
                  )),
              20.0.height,
              BaseButton.primary(
                text: "Ganti Password",
                onPressed: () =>
                    Navigator.pushNamed(context, ResetPassScreen.routeName),
                width: double.infinity,
              ),
              10.0.height,
              BaseButton.outlined(
                text: "Keluar",
                onPressed: () => controller.logout(context),
                width: double.infinity,
              ),
              10.0.height,
            ],
          ),
        ),
      ),
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
