import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final bool isAdmin;
  final Function(int) onNavigationChanged;
  final int selectedIndex;
  final PageController pageController;

  const ProfilePage({
    super.key,
    required this.isAdmin,
    required this.onNavigationChanged,
    required this.selectedIndex,
    required this.pageController,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    final double titleSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
          child: const Text('About You',
              style: TextStyle(color: Colors.black)),
        ),
      ),
      );
  }
}