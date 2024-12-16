import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'academic_info_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String gender;
  final String firstName;
  final String lastName;

  const EmailVerificationScreen({
    super.key,
    required this.gender,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/illustrations/email_illus.svg',
              height: 200,
            ),
            const SizedBox(height: 50,),
            TextField(
              controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
              onChanged: (value) {
                // Validate email domain
                if (!value.endsWith('@atharvacoe.ac.in')) {
                  // Show error
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
              obscureText: true,
            ),
            if (_isOtpSent) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _otpController,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (!_isOtpSent) {
                  // TODO: Implement Firebase email verification
                  // FirebaseAuth.instance.sendSignInLinkToEmail(
                  //   email: _emailController.text,
                  //   actionCodeSettings: ActionCodeSettings(...),
                  // );
                  setState(() => _isOtpSent = true);
                } else {
                  // TODO: Verify OTP
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcademicInfoScreen(
                        gender: widget.gender,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        email: _emailController.text,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
              ),
              child: Text(_isOtpSent ? 'Verify OTP' : 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
} 