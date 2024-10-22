import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class AuthLoginScreen extends StatelessWidget {
  static const String routeName = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthLoginController(),
      child:
          Consumer<AuthLoginController>(builder: (context, controller, child) {
        return Scaffold(
          // Enable resizing when the keyboard appears
          resizeToAvoidBottomInset: true,
          body: LayoutContainer(
            child: Stack(
              children: [
                Container(
                  color: PreferenceColors.purple,
                  width: Dimensions.width(context),
                  height: Dimensions.height(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.Logo,
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        height: Dimensions.height(context) * 0.3,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Dimensions.width(context),
                    height: Dimensions.height(context) * 0.45,
                    decoration: BoxDecoration(
                      color: PreferenceColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(  // Wrap this Container with SingleChildScrollView
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height(context) / 30,
                        horizontal: Dimensions.width(context) / 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText.S("Halo, Selamat Datang Kembali"),
                          5.0.height,
                          BaseText.L(
                            "Silahkan Masuk",
                            fontWeight: FontWeight.w600,
                          ),
                          30.0.height,
                          BaseInput.cupertino(
                            labelText: "Nomor Induk",
                          ),
                          30.0.height,
                          BaseInput.cupertino(
                            labelText: "Password",
                            isPasswordInput: true,
                          ),
                          25.0.height,
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(context, MainScreen.routeName)
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
                                  "Masuk",
                                  color: PreferenceColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          10.0.height,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
