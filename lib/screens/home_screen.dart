import 'package:flutter/material.dart';
import '../widgets/post_widget.dart';
import '../data/posts_data.dart';
import '../screens/comments_screen.dart';
import '../screens/notification_screen.dart';
import 'package:intl/intl.dart';
import '../widgets/scroll_behavior.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/profile_picture.dart';
import 'package:post_ace/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;
  final String userName;
  final String profileUrl;

  const HomeScreen({
    super.key,
    required this.isAdmin,
    required this.userName,
    required this.profileUrl,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _messageController = TextEditingController();
  double _titleSize = 28;
  int _selectedIndex = 0;

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _fetchMessages();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    const maxSize = 28.0;
    const minSize = 20.0;

    setState(() {
      _titleSize = (maxSize - (offset / 50)).clamp(minSize, maxSize);
    });
  }

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.2.106:5000/api/post/getMsg'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Response: $data');
        final List<dynamic> messagesData = data['data'] ?? [];
        print('Messages Data: $messagesData');
        setState(() {
          messages = messagesData
              .map((json) => Message.fromJson(json))
              .toList()
              .reversed
              .toList();
        });
      } else {
        print('Error Status Code: ${response.statusCode}');
        print('Error Response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _selectedIndex == 0
        ? Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: _titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text(
                      'Welcome',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              actions: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfilePicture(
                      profileurl: widget.profileUrl,
                    ),
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final post = messages[index];
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CommentsScreen(post: post),
                          //   ),
                          // );
                        },
                        child: PostWidget(
                          adminName: post.username,
                          timeAgo: post.getFormattedTimestamp(),
                          content: post.message,
                          imageUrls: const [],
                          likesCount: 41,
                          commentsCount: 21,
                          isSaved: post.username == widget.userName,
                          onLike: () {
                            // TODO: Implement Firebase like functionality
                          },
                          // onComment: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           CommentsScreen(post: post),
                          //     ),
                          //   );
                          // },
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

            // Bottom Navigation Bar
            bottomNavigationBar: CustomBottomNav(
              selectedIndex: _selectedIndex,
              onTabChange: _onNavigationChanged,
            ),

          )
        : NotificationScreen(
            isAdmin: widget.isAdmin,
            onNavigationChanged: _onNavigationChanged,
            selectedIndex: _selectedIndex,
          );
  }

  void _showCreatePostDialog(BuildContext context) {
    Future<void> postMessage() async {
      try {
        final response = await http.post(
          Uri.parse(
              'http://192.168.2.106:5000/api/post/postMsg'), // Replace with your API endpoint
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "Username": widget.userName,
            'Message': _messageController.text,
          }),
        );

        if (response.statusCode == 201) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Message posted successfully!')),
            );
            Navigator.pop(context);
          }
        } else {
          throw Exception('Failed to post message');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }

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
              controller: _messageController,
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
              onPressed: postMessage,
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

class Message {
  final String username;
  final String message;
  final DateTime timestamp;

  Message(
      {required this.username, required this.message, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    print('Raw JSON: $json');
    return Message(
      username: json['username'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(
        json['timestamp'] ?? 'Just Now',
      ),
    );
  }
  String getFormattedTimestamp() {
    final formatter = DateFormat('MMM dd, yyyy hh:mm a');
    return formatter.format(timestamp);
  }
}
