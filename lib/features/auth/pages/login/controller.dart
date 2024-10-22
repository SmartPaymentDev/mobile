import 'package:flutter/material.dart';
import 'package:ibnu_abbas/features/main/main.dart';

class AuthLoginController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> doSignIn(BuildContext context) async {
    if (_isLoading) false;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, MainScreen.routeName);
      _isLoading = false;
      notifyListeners();
    });
  }
}