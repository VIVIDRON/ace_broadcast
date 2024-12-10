class Post {
  final String adminName;
  final String timeAgo;
  final String content;
  final List<String>? imageUrls;
  final int likesCount;
  final int commentsCount;
  final bool isSaved;

  Post({
    required this.adminName,
    required this.timeAgo,
    required this.content,
    this.imageUrls,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isSaved = false,
  });
} 