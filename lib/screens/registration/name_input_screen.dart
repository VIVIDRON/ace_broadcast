import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'email_verification_screen.dart';

class NameInputScreen extends StatefulWidget {
  final String gender;

  const NameInputScreen({super.key, required this.gender});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Your Name')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/illustrations/name_illus.svg',
              height: 200,
            ),
            const SizedBox(height: 50,),
            TextField(
              controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailVerificationScreen(
                      gender: widget.gender,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
