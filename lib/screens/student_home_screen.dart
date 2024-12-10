import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Firebase Firestore setup
    // 1. Create posts collection listener
    // 2. Setup real-time updates for posts
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Navigate to profile screen
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
              onChanged: (value) {
                // TODO: Implement Firestore search query
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                PostCard(
                  adminName: 'Admin',
                  timeAgo: '2h ago',
                  content: 'This is a test post',
                  imageUrl: 'https://example.com/image.jpg',
                ),
                // TODO: Replace with StreamBuilder for Firestore posts
              ],
            ),
          ),
        ],
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