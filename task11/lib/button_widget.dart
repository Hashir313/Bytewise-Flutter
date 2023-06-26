// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'mercury.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 10.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 80, 109, 138),
            Color.fromARGB(255, 170, 114, 114)
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () async {
          final data = await fetchMercuryData();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 173, 132, 132),
              shadowColor: const Color.fromARGB(255, 170, 114, 114),
              title: const Text('Mercury Data'),
              content: Text(data.toString()),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: GoogleFonts.openSans(
                      fontSize: 20.sp,
                      letterSpacing: 8.5.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Text(
          'Click For More Information',
          style: GoogleFonts.openSans(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
