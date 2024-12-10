import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Firebase Admin Authentication
    // 1. Verify admin privileges
    // 2. Setup admin-specific Firestore rules
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Navigate to admin profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                PostCard(
                  adminName: 'Admin',
                  timeAgo: '2h ago',
                  content: 'Test post',
                  isAdmin: true,
                ),
                // TODO: Replace with StreamBuilder for Firestore posts
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create post screen
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
} 