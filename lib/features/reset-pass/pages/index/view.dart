import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class ResetPassScreen extends StatelessWidget {
  static const String routeName = '/reset-pass';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasssController(),
      child:
          Consumer<ResetPasssController>(builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: BaseText.L(
              "Ganti Password",
              color: PreferenceColors.yellow,
              fontWeight: FontWeight.w500,
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
                vertical: Dimensions.height(context) / 60,
              ),
              width: Dimensions.width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseInput.underlined(
                    labelText: "Password Baru",
                    isPasswordInput: true,
                  ),
                  15.0.height,
                  BaseInput.underlined(
                    labelText: "Konfirmasi Password Baru",
                    isPasswordInput: true,
                  ),
                  20.0.height,
                  GestureDetector(
                    onTap: () =>
                        {Navigator.pushNamed(context, MainScreen.routeName)},
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
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
