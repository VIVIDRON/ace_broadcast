import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:post_ace/utils/theme.dart';
import 'screens/selection_screen.dart';
import './firebase_option.dart';
import 'package:provider/provider.dart';
import 'utils/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Updates',
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().themeMode,
      theme: lightMode,
      darkTheme: darkMode,
      home: const SelectionScreen(),
    );
  }
}
