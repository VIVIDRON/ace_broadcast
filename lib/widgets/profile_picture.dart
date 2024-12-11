import 'package:flutter/material.dart';
// TODO: Uncomment when Firebase is setup
// import '../services/auth_service.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  const ProfilePicture({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[200],
      child: const Icon(
        Icons.person,
        color: Colors.black87,
      ),
    );
  }
} 