import 'package:demo/fake_store/core/color.dart';
import 'package:demo/fake_store/presentation/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<BottomNavController>(context)
          .screens[Provider.of<BottomNavController>(context).selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorTheme.white,
          currentIndex:
          Provider.of<BottomNavController>(context).selectedIndex,
          onTap:
          Provider.of<BottomNavController>(context, listen: false)
              .onItemTap,
          elevation: 0,
          selectedIconTheme:  IconThemeData(
            color: ColorTheme.mainClr,
            size: 25,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 25,
          ),
          unselectedItemColor: Colors.grey,
          selectedItemColor: ColorTheme.mainClr,
          showSelectedLabels: true,
          showUnselectedLabels: false,items: [
        BottomNavigationBarItem(
            backgroundColor: ColorTheme.darkClr,
            icon: Icon(Icons.home),
            label: "Home"),
        BottomNavigationBarItem(
            backgroundColor: ColorTheme.darkClr,
            icon: Icon(Icons.category),
              label: "Category"),
      ]),
    );
  }
}
