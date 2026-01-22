import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quomodo/core/nav_bar/controller/navbar_controller.dart';
import 'package:quomodo/feature/home/view/home_screen.dart';
import 'package:quomodo/feature/message/view/message_screen.dart';
import 'package:quomodo/feature/order/view/order_screen.dart';
import 'package:quomodo/feature/profile/view/profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final MainController mainController = Get.put(MainController());

  final List<Widget> pages = [
    HomeScreen(),
    MessageScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[mainController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: mainController.currentIndex.value,
          onTap: (index) => mainController.changePage(index),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.home,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              NavBarItem(
                icon: Icons.chat_bubble_outline,
                label: 'Message',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              NavBarItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Order',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              NavBarItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.orange : Colors.grey[400],
            size: 28,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.orange : Colors.grey[400],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
