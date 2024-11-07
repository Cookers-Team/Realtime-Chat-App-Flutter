import 'package:flutter/material.dart';

Widget buildTabBarContainer(
  Color primaryColor,
  Color secondaryColor,
  TabController tabController,
  List<String> tabTitles,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    color: primaryColor,
    child: TabBar(
      controller: tabController,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.blue[300],
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      tabs: tabTitles.map((title) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Tab(text: title),
        );
      }).toList(),
    ),
  );
}
