import 'package:firebase_crud/view/add_screen.dart';
import 'package:firebase_crud/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:simple_floating_bottom_nav_bar/floating_bottom_nav_bar.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
   BottomNavBar({super.key});

  List<FloatingBottomNavItem> bottomNavItems = const [
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Home",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: "Add",
    ),
  ];

  List<Widget> pages = [
    const HomeScreen(),
    AddScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingBottomNavBar(
      pages: pages,
      items: bottomNavItems,
      initialPageIndex: 0,
      backgroundColor: const Color.fromARGB(255, 175, 76, 102),
      bottomPadding: 10,
      elevation: 0,
      radius: 20,
      width: 180,
      height: 65,
    );
  }
}
