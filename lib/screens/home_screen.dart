import 'package:flutter/material.dart';
import '../widgets/post_widget.dart';
import '../data/posts_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/comments_screen.dart';
import '../screens/notification_screen.dart';
import '../widgets/scroll_behavior.dart';
import '../widgets/profile_picture.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;

  const HomeScreen({super.key, required this.isAdmin});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _titleSize = 28;
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

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return _selectedIndex == 0
        ? Scaffold(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 16),
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
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
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
                                builder: (context) =>
                                    CommentsScreen(post: post),
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
            floatingActionButton: widget.isAdmin
                ? FloatingActionButton(
                    onPressed: () {
                      _showCreatePostDialog(context);
                    },
                    backgroundColor: const Color(0xFF6C63FF),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                splashFactory:
                    NoSplash.splashFactory, // Disables the ripple effect
                highlightColor:
                    Colors.transparent, // Removes highlight on long press
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onNavigationChanged,
                backgroundColor: Colors.white,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
            ),
          )
        : NotificationScreen(
            isAdmin: widget.isAdmin,
            onNavigationChanged: _onNavigationChanged,
            selectedIndex: _selectedIndex,
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
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
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
