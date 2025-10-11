import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SkypeClone());
}

class SkypeClone extends StatelessWidget {
  const SkypeClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skype Clone',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}