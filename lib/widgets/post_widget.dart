import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  final String adminName;
  final String timeAgo;
  final String content;
  final List<String>? imageUrls;
  final int likesCount;
  final int commentsCount;
  final bool isSaved;
  final bool isLiked;
  final Function()? onLike;
  final Function()? onComment;
  final Function()? onShare;
  final Function()? onSave;

  const PostWidget({
    super.key,
    required this.adminName,
    required this.timeAgo,
    required this.content,
    this.imageUrls,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isSaved = false,
    this.onLike,
    this.isLiked = false,
    this.onComment,
    this.onShare,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Admin info and save button
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(
                adminName[0].toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            title: Text(
              adminName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              timeAgo,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isSaved ? Icons.star : Icons.star_border,
                color: isSaved ? Colors.amber : Colors.grey,
              ),
              onPressed: onSave,
            ),
          ),

          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Images if any
          if (imageUrls != null && imageUrls!.isNotEmpty) ...[
            const SizedBox(height: 8),
            if (imageUrls!.length == 1)
              Image.network(
                imageUrls![0],
                fit: BoxFit.cover,
              )
            else
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageUrls!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16 : 8,
                        right: index == imageUrls!.length - 1 ? 16 : 0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrls![index],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],

          // Interaction buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: onLike,
                  icon: SvgPicture.asset(
                    'assets/icons/like.svg',
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isLiked ? Colors.red : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text(
                    '$likesCount',
                    style: TextStyle(
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: isLiked ? Colors.red : Colors.black,
                  ),
                ),
                TextButton.icon(
                  onPressed: onComment,
                  icon: SvgPicture.asset(
                    'assets/icons/comment.svg',
                    height: 24,
                    width: 24,
                  ),
                  label: Text('$commentsCount'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                TextButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Share'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
