import 'package:flutter/material.dart';
import '../widgets/post_widget.dart';
import '../data/posts_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/scroll_behavior.dart';
import '../screens/comments_screen.dart';
import '../widgets/profile_picture.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _titleSize = 28;
  // ignore: unused_field
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
                  color: _selectedIndex == 0
                      ? const Color(0xFF6C63FF).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
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
                  color: _selectedIndex == 1
                      ? const Color(0xFF6C63FF).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'assets/icons/bell.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
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
    );
  }
}
