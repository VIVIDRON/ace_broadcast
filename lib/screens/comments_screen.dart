import 'package:flutter/material.dart';
import '../widgets/post_widget.dart';
import '../models/post.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;

  const CommentsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          PostWidget(
            adminName: post.adminName,
            timeAgo: post.timeAgo,
            content: post.content,
            imageUrls: post.imageUrls,
            likesCount: post.likesCount,
            commentsCount: post.commentsCount,
            isSaved: post.isSaved,
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