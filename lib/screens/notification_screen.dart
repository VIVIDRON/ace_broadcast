import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  final bool isAdmin;
  final Function(int) onNavigationChanged;
  final int selectedIndex;
  final double titleSize = 28;

  const NotificationScreen({
    super.key,
    required this.isAdmin,
    required this.onNavigationChanged,
    required this.selectedIndex,
  });

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
          child: const Text('Notifications',
          style: TextStyle(color: Colors.black)),
        ),
      ),
      body: const Center(
        child: Text('Notifications will appear here'),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory, // Disables the ripple effect
          highlightColor: Colors.transparent, // Removes highlight on long press
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onNavigationChanged,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Material(
                type: MaterialType.transparency,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? const Color(0xFF6C63FF).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 0
                          ? const Color(0xFF6C63FF)
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Material(
                type: MaterialType.transparency,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? const Color(0xFF6C63FF).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/bell.svg',
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 1
                          ? const Color(0xFF6C63FF)
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: 'Notifications',
            ),
          ],
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
