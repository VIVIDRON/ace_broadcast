import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'username_confirmation_screen.dart';

class AcademicInfoScreen extends StatefulWidget {
  final String gender;
  final String firstName;
  final String lastName;
  final String email;

  const AcademicInfoScreen({
    super.key,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<AcademicInfoScreen> createState() => _AcademicInfoScreenState();
}

class _AcademicInfoScreenState extends State<AcademicInfoScreen> {
  String? _selectedYear;
  String? _selectedBranch;

  final _years = ['FE', 'SE', 'TE', 'BE'];
  final _branches = ['CMPN', 'INFT', 'EXTC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Academic Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/illustrations/academic_illus.svg',
              height: 200,
            ),
            const SizedBox(height: 50,),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              items: _years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedYear = value),
              decoration: const InputDecoration(labelText: 'Select Year',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBranch,
              items: _branches.map((branch) {
                return DropdownMenuItem(
                  value: branch,
                  child: Text(branch),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedBranch = value),
              decoration: const InputDecoration(labelText: 'Select Branch'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_selectedYear != null && _selectedBranch != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsernameConfirmationScreen(
                        gender: widget.gender,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        email: widget.email,
                        year: _selectedYear!,
                        branch: _selectedBranch!,
                      ),
                    ),
                  );
                }
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