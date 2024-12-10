import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Firebase Comments Setup
    // 1. Create comments subcollection in posts
    // 2. Setup real-time comment listeners
    // 3. Implement comment posting functionality
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          const PostCard(
            adminName: 'Admin',
            timeAgo: '2h ago',
            content: 'Original post content',
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('S'),
                  ),
                  title: Text('Student 1'),
                  subtitle: Text('Great post!'),
                ),
                // TODO: Replace with StreamBuilder for comments
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your reply here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // TODO: Implement Firebase comment posting
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 