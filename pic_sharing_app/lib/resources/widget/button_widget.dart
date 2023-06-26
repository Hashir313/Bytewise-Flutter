import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool loading;

  const ButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
        height: 50.0,
        width: 250.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors().primaryColor, AppColors().secondaryColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
            borderRadius: BorderRadius.circular(30.0)),
        child: Center(
          child: loading == true
              ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3.0,
          )
              : Text(
                  buttonText,
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
        ),
      ),
    );
  }
}
