import 'package:flutter/material.dart';
// TODO: Uncomment when Firebase is setup
// import '../services/auth_service.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment and use this when Firebase is setup
    // final user = AuthService().currentUser;

    return CircleAvatar(
      // TODO: Replace with actual user profile image when Firebase is setup
      // backgroundImage: user?.photoURL != null 
      //     ? NetworkImage(user!.photoURL!) 
      //     : null,
      backgroundColor: Colors.grey[200],
      child: const Icon(
        Icons.person,
        color: Colors.black87,
      ),
      // TODO: Replace with user initials when Firebase is setup
      // child: user?.photoURL == null
      //     ? Text(
      //         user?.initials ?? 'U',
      //         style: const TextStyle(
      //           color: Colors.black87,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       )
      //     : null,
    );
  }
} 