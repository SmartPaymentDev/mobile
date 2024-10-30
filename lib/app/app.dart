import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ibnu_abbas/features/home/pages/index/controller.dart';
import 'package:ibnu_abbas/features/payment/pages/index/controller.dart';
import 'package:provider/provider.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/auth/pages/login/view.dart';
import 'package:ibnu_abbas/features/main/main.dart';
import 'package:ibnu_abbas/features/bill/pages/index/controller.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  final _storage = const FlutterSecureStorage();

  Future<bool> _checkLoginStatus() async {
    String? token = await _storage.read(key: 'authToken');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BillController()),
        ChangeNotifierProvider(create: (_) => PaymentController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        title: 'Nectar',
        debugShowCheckedModeBanner: false,
        theme: ThemeLight(PreferenceColors.purple).theme,
        onGenerateRoute: routes,
        home: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              return const MainScreen();
            } else {
              return AuthLoginScreen();
            }
          },
        ),
      ),
    );
  }
}
