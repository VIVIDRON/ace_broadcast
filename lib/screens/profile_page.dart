import 'package:flutter/material.dart';
import 'package:post_ace/screens/theme_selection.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
            ),
            child: Text('About You',
                style: TextStyle(color: theme.colorScheme.inversePrimary)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Picture with user name
              // saved posts
              // [ADMIN] Posts created
              // Signout

              // ThemePage
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThemeSelection()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
