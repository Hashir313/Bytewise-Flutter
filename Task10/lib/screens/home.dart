import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringProvider = Provider<String>((ref) {
  return "Flutter Riverpod";
},);

class HomeScreens extends ConsumerWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    String ourData = ref.read<String>(stringProvider);
    return Scaffold(
      body: Center(
      child: Text(
        ourData,
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.purple
        ),
      ),
    ),
    );
  }
}