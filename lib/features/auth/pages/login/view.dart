import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class AuthLoginScreen extends StatelessWidget {
  static const String routeName = '/auth/login';

  final TextEditingController _nocustController = TextEditingController();
  final TextEditingController _mobilepasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthLoginController(),
      child: Consumer<AuthLoginController>(
        builder: (context, controller, child) {
          return Scaffold(
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
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: Dimensions.height(context) * 0.3),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Dimensions.width(context),
                      height: Dimensions.height(context) * 0.4,
                      decoration: BoxDecoration(
                        color: PreferenceColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height(context) / 25,
                          horizontal: Dimensions.width(context) / 20,
                        ),
                        child: Column(
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
                              controller: _nocustController,
                              labelText: "Nomor Induk",
                            ),
                            30.0.height,
                            BaseInput.cupertino(
                              controller: _mobilepasswordController,
                              labelText: "Password",
                              isPasswordInput: true,
                            ),
                            30.0.height,
                            GestureDetector(
                              onTap: () {
                                controller.doSignIn(
                                  context,
                                  _nocustController.text,
                                  _mobilepasswordController.text,
                                );
                              },
                              child: Container(
                                height: Dimensions.dp48,
                                width: Dimensions.width(context),
                                decoration: BoxDecoration(
                                  color: PreferenceColors.purple,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: controller.isLoading
                                      ? CircularProgressIndicator(
                                          color: PreferenceColors.white,
                                        )
                                      : BaseText.M(
                                          "Masuk",
                                          color: PreferenceColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
