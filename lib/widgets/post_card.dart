import 'package:flutter/material.dart';
import '../screens/comments_screen.dart';

class PostCard extends StatelessWidget {
  final String adminName;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final bool isAdmin;

  const PostCard({
    super.key,
    required this.adminName,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement Firebase Firestore listeners for likes, comments count
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(adminName[0]),
            ),
            title: Text(adminName),
            subtitle: Text(timeAgo),
            trailing: IconButton(
              icon: const Icon(Icons.star_border),
              onPressed: () {
                // TODO: Implement Firebase save to favorites
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content),
          ),
          if (imageUrl != null)
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up_outlined),
                onPressed: () {
                  // TODO: Implement Firebase like functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommentsScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
} 