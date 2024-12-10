import '../models/post.dart';

class PostsData {
  static final List<Post> posts = [
    Post(
      adminName: 'Prof. Smith',
      timeAgo: '2h ago',
      content: 'Important notice: Mid-term examinations will begin from next week. Please check your hall tickets.',
      likesCount: 42,
      commentsCount: 15,
    ),
    Post(
      adminName: 'HOD Computer',
      timeAgo: '5h ago',
      content: 'Workshop on Flutter Development this weekend!',
      imageUrls: [
        'https://example.com/workshop1.jpg',
        'https://example.com/workshop2.jpg',
      ],
      likesCount: 28,
      commentsCount: 8,
    ),
    Post(
      adminName: 'College Admin',
      timeAgo: '1d ago',
      content: 'Annual college fest dates announced! Mark your calendars for an exciting event.',
      imageUrls: ['https://example.com/fest.jpg'],
      likesCount: 156,
      commentsCount: 45,
    ),
  ];
} 