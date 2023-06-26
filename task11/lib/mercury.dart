import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'button_widget.dart';

class Mercury extends StatefulWidget {
  const Mercury({super.key});

  @override
  State<Mercury> createState() => _MercuryState();
}

class _MercuryState extends State<Mercury> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  //
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  ///////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 14, 80, 146), Colors.black],
            stops: [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
          child: Column(
            children: [
              Center(
                child: Text(
                  'MERCURY',
                  style: GoogleFonts.openSans(
                    fontSize: 26.sp,
                    letterSpacing: 8.5.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            child: Text(
                              'Living up to its name, Mercury is the fastest planet in the solar system, speeding along at about 29 miles per second and completing each orbit around the sun in just 88 Earth days. Mercury is also the smallest planet in the solar system, measuring just 3,032 miles wide at its equator.',
                              style: GoogleFonts.openSans(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 42.sp),
                              child: RotationTransition(
                                turns: _animation,
                                child: Image(
                                  image: const AssetImage('assets/m.png'),
                                  width: 46.w,
                                  height: 25.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Button(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchMercuryData() async {
  final response = await http
      .get(Uri.parse('https://api.le-systeme-solaire.net/rest/bodies/mercury'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
