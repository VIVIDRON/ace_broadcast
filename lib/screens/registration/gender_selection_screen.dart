import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'name_input_screen.dart';

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Gender')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/illustrations/male_illus.svg',
                  height: 200,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 103, 161, 247),
                    side: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                  ),
                  onPressed: () => _navigateToNameInput(context, 'Male'),
                  child: const Text('Male'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/illustrations/female_illus.svg',
                  height: 200,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 247, 103, 227),
                    side: const BorderSide(color: Color(0xFFF11FD4), width: 2),
                  ),
                  onPressed: () => _navigateToNameInput(context, 'Female'),
                  child: const Text('Female'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNameInput(BuildContext context, String gender) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NameInputScreen(gender: gender),
      ),
    );
  }
}
