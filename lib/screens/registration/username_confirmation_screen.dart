import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../home_screen.dart';

class UsernameConfirmationScreen extends StatefulWidget {
  final String gender;
  final String firstName;
  final String lastName;
  final String email;
  final String year;
  final String branch;

  const UsernameConfirmationScreen({
    super.key,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.year,
    required this.branch,
  });

  @override
  State<UsernameConfirmationScreen> createState() => _UsernameConfirmationScreenState();
}

class _UsernameConfirmationScreenState extends State<UsernameConfirmationScreen> {
  late String username;
  late String currentYear;

  @override
  void initState() {
    super.initState();
    _generateUsername();
  }

  void _generateUsername() {
    final now = DateTime.now();
    currentYear = widget.year;
    
    // Update year based on current month
    if (now.month >= 5) {
      switch (widget.year) {
        case 'FE':
          currentYear = 'SE';
          break;
        case 'SE':
          currentYear = 'TE';
          break;
        case 'TE':
          currentYear = 'BE';
          break;
        case 'BE':
          currentYear = 'PO';
          break;
      }
    }

    username = '${widget.firstName.toLowerCase()}${widget.lastName.toLowerCase()}_${widget.branch.toLowerCase()}_$currentYear';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Username')),
      body: Padding(
        padding: const EdgeInsets.all(55),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/illustrations/identity_illus.svg',
                height: 200,
              ),
              Text(
                'Your username will be:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(18.0),
    border: Border.all(
      color: Colors.blue, // Outline color
      width: 2,          // Outline thickness
    ),
  ),
  padding: const EdgeInsets.all(8.0), // Adds spacing inside the border
  child: Text(
    username,
    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: const Color.fromARGB(255, 31, 3, 194), // Set text color to white
        ),
  ),
),


              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // TODO: Save user data to Firebase
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(isAdmin: false),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 