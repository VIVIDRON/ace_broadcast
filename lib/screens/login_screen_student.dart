import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_ace/services/auth_service.dart';

class LoginScreenStudent extends StatefulWidget {
  const LoginScreenStudent({super.key});

  @override
  State<LoginScreenStudent> createState() => _LoginScreenStudentState();
}

class _LoginScreenStudentState extends State<LoginScreenStudent> {
  final AuthService _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    String email = _email.text;
    String password = _password.text;

    if (!email.endsWith('@atharvacoe.ac.in')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please use your college email address'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final User? user = await _auth.loginUserWithEmailId(email, password);
    if (user != null && context.mounted) {
      print("User Successfully logged in");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(
            isAdmin: false,
            userName: 'Student',
            profileUrl: '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 40),
          const Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/illustrations/login_student_illus.svg',
                      height: 250,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            final UserCredential? userCred =
                                await _auth.loginWithGoggle();
                            if (userCred != null && context.mounted) {
                              final User? user = userCred.user;
                              final String? email = user?.email;

                              if (email != null &&
                                  email.endsWith('@atharvacoe.ac.in')) {
                                print("User Successfully logged in");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Successful!'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      isAdmin: false,
                                      userName: user?.displayName ?? 'Student',
                                      profileUrl: user?.photoURL ?? '',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please use your college email address'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            print("Error during Google Sign In: $e");
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/google_logo.svg',
                          height: 24,
                        ),
                        label: const Text('Sign-in with Google'),
                      ),
                    ),
                    const SizedBox(height: 26),

                    //REMOVE THE BELOW CODE Only for testing
                    SizedBox(
                      width: 180,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(
                                isAdmin: false,
                                userName: 'Admin',
                                profileUrl: '',
                              ),
                            ),
                          );
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Bypass Login'),
                      ),
                    ),
                    // Till Here
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
