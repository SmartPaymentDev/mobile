import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class ResetPassScreen extends StatefulWidget {
  static const String routeName = '/reset-pass';

  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ResetPasssController>(context, listen: false).fetchData();
    });
  }


  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResetPasssController>(context);
    final TextEditingController _oldPasswordController =
        TextEditingController();
    final TextEditingController _newPasswordController =
        TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: BaseText.L(
          "Ganti Password",
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
            vertical: Dimensions.height(context) / 60,
          ),
          width: Dimensions.width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseInput.underlined(
                labelText: "Password Lama",
                isPasswordInput: true,
                controller: _oldPasswordController,
              ),
              15.0.height,
              BaseInput.underlined(
                labelText: "Password Baru",
                isPasswordInput: true,
                controller: _newPasswordController,
              ),
              15.0.height,
              BaseInput.underlined(
                labelText: "Konfirmasi Password",
                isPasswordInput: true,
                controller: _confirmPasswordController,
              ),
              20.0.height,
              BaseButton.primary(
                text: "Ganti Password",
                onPressed: () => controller.changePass(
                    context,
                    _oldPasswordController.text,
                    _newPasswordController.text,
                    _confirmPasswordController.text),
                width: double.infinity,
                isLoading: controller.isLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
