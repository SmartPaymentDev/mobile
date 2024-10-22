import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData outlinedIcon;
  final IconData filledIcon;
  final Widget page;

  NavItem({
    required this.label,
    required this.outlinedIcon,
    required this.filledIcon,
    required this.page,
  });
}
