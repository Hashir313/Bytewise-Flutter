import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../future_provider/weather_function.dart';

final weatherProvider = FutureProvider.autoDispose<String>(
  (ref) => fetchWeatherReport(),
);

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Today's Weather",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          backgroundColor: Colors.amberAccent),
      body: ref.watch(weatherProvider).when(
        data: (data) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://th.bing.com/th/id/OIP.aVFWI-BgJhDDcmwSr3RrfAHaEo?pid=ImgDet&rs=1",
                ),
                fit: BoxFit.cover
              ),
            ),
            child: Center(
              child: Text(
                data,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
