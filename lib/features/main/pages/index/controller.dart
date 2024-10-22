import 'package:flutter/material.dart';
import 'package:ibnu_abbas/features/account/pages/index/view.dart';
import 'package:ibnu_abbas/features/home/home.dart';
import 'package:ibnu_abbas/features/history/pages/index/view.dart';
import 'model.dart';

class MainScreenController extends ChangeNotifier {
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem(
      label: 'Beranda', 
      outlinedIcon: Icons.home_outlined, 
      filledIcon: Icons.home, 
      page: const HomeScreen()
    ),
    NavItem(
      label: 'Riwayat', 
      outlinedIcon: Icons.list_alt_outlined, 
      filledIcon: Icons.list_alt, 
      page: const HistoryScreen()
    ),
    NavItem(
      label: 'Profil', 
      outlinedIcon: Icons.account_circle_outlined, 
      filledIcon: Icons.account_circle, 
      page: const AccountScreen()
    ),
  ];

  int get selectedIndex => _selectedIndex;
  List<NavItem> get navItems => _navItems;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
