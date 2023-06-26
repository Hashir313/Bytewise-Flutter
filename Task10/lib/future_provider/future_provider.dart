import 'package:flutter/material.dart';

import '../screens/weather_screen.dart';

class FutureProvide extends StatelessWidget {
  const FutureProvide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Riverpod",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.amberAccent
      ),
      body: Center(
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WeatherScreen(),
            ),
          );
        },
        child: Container(
          width: 250.0,
          height: 70.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
              color: Colors.amberAccent),
          child: const Center(
            child: Text(
              'FutureProvider',
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.red
                  //backgroundColor: Color.fromARGB(255, 11, 84, 143),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
