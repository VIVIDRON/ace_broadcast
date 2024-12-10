import 'package:flutter/material.dart';
import '../widgets/post_widget.dart';
import '../data/posts_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/comments_screen.dart';
import '../widgets/scroll_behavior.dart';
import '../widgets/profile_picture.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _titleSize = 28;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final maxSize = 28.0;
    final minSize = 20.0;

    setState(() {
      _titleSize = (maxSize - (offset / 50)).clamp(minSize, maxSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: _titleSize,
            fontWeight: FontWeight.bold,
          ),
          child: const Text(
            'Homepage',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [
          ProfilePicture(),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          ScrollToHideWidget(
            controller: _scrollController,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 16), // Add this for text size
                decoration: InputDecoration(
                  hintText: 'Search posts...',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 170, 170, 170),
                    fontSize: 16,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search, color: Colors.grey[400]),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  isDense: false, // Change this to false
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16), // Increase vertical padding
                ),
                onChanged: (value) {
                  // TODO: Implement Firestore search query
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: PostsData.posts.length,
              itemBuilder: (context, index) {
                final post = PostsData.posts[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(post: post),
                      ),
                    );
                  },
                  child: PostWidget(
                    adminName: post.adminName,
                    timeAgo: post.timeAgo,
                    content: post.content,
                    imageUrls: post.imageUrls,
                    likesCount: post.likesCount,
                    commentsCount: post.commentsCount,
                    isSaved: post.isSaved,
                    onLike: () {
                      // TODO: Implement Firebase like functionality
                    },
                    onComment: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(post: post),
                        ),
                      );
                    },
                    onShare: () {
                      // TODO: Implement share functionality
                    },
                    onSave: () {
                      // TODO: Implement Firebase save functionality
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog(context);
        },
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bell.svg',
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create New Post',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What would you like to announce?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement image picker
              },
              icon: const Icon(Icons.image),
              label: const Text('Add Images'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement post creation in Firebase
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Post'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
