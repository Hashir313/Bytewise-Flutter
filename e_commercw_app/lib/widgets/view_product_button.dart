import 'package:e_commercw_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewProductButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  const ViewProductButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: AppColors().buttonColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: GoogleFonts.robotoCondensed(
                  color: AppColors().backgroudColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }
}
