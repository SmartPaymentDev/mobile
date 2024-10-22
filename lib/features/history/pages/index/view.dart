import 'package:flutter/material.dart';
import 'package:ibnu_abbas/core/core.dart';
import 'package:ibnu_abbas/features/history/pages/index/controller.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryController(),
      child: Consumer<HistoryController>(builder: (context, controller, child) {
        return DefaultTabController(
          length: 3, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: BaseText.L(
                
                "Riwayat",
                color: PreferenceColors.yellow,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: PreferenceColors.purple,
              elevation: 0, // Removes shadow from the AppBar
              bottom: TabBar(
                labelColor: PreferenceColors.yellow,
                unselectedLabelColor: Colors.white, 
                indicatorColor: PreferenceColors.yellow,
                tabs: [
                  Tab(text: "Semua"),
                  Tab(text: "SPP"),
                  Tab(text: "Saku"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // First tab content (ALL)
                Center(
                  child: BaseText.M("Tidak Ada Riwayat"),
                ),
                // Second tab content (SPP & SAKU)
                Center(
                  child: BaseText.M("Tidak Ada Riwayat"),
                ),
                Center(
                  child: BaseText.M("Tidak Ada Riwayat"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
