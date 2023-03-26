import 'package:flutter/material.dart';
import 'package:navigation_and_router/ui/homeScreen.dart';
import 'package:navigation_and_router/ui/loginScreen.dart';
import 'package:navigation_and_router/ui/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routes',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/Signup': (context) => const SignupScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
