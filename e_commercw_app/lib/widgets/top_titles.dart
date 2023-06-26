import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAndSubTitle extends StatelessWidget {
  final String title, subTitle;
  final Color titleColor , subTitleColor;
  const TitleAndSubTitle(
      {super.key, required this.title, required this.subTitle, required this.titleColor, required this.subTitleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Zolina Bold",
            fontSize: 28.0,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(subTitle,
            style: GoogleFonts.figtree(
                color: subTitleColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
