import 'package:flutter/material.dart';

class LayoutContainer extends StatelessWidget {
  final Widget child;

  const LayoutContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure full width
      child: SingleChildScrollView(
        child: Column( // Wrap child in Column
          children: [
            child,
          ],
        ),
      ),
    );
  }
}
