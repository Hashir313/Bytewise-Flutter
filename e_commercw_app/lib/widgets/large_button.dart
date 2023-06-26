import 'package:e_commercw_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final bool loading;
  const LargeButtonWidget(
      {super.key,
      required this.onTap,
      required this.buttonText,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? CircularProgressIndicator(
            color: AppColors().backgroudColor,
            backgroundColor: AppColors().primaryColor,
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              height: 50.0,
              width: 250.0,
              decoration: BoxDecoration(
                  color: AppColors().buttonColor,
                  borderRadius: BorderRadius.circular(20.0)),
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
