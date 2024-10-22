import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});

  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: controller.navItems[controller.selectedIndex].page,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 50,
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: PreferenceColors.white,
              type: BottomNavigationBarType.fixed,
              items: controller.navItems.map((navItem) {
                int index = controller.navItems.indexOf(navItem);
                bool isSelected = index == controller.selectedIndex;

                return BottomNavigationBarItem(
                  icon: Icon(
                    isSelected ? navItem.filledIcon : navItem.outlinedIcon,
                  ),
                  label: navItem.label,
                );
              }).toList(),
              currentIndex: controller.selectedIndex,
              onTap: controller.onItemTapped,
              unselectedItemColor: PreferenceColors.black.shade500,
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
              selectedFontSize: Dimensions.dp10,
              unselectedFontSize: Dimensions.dp10,
            ),
          ),
        );
      },
    );
  }
}
