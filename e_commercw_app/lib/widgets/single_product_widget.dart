import 'package:e_commercw_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProductWidget extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final VoidCallback onPressed;

  const SingleProductWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors().primaryColor,
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            productImage,
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            productName,
            style: GoogleFonts.figtree(
              fontSize: 18.0,
              color: AppColors().textColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "\$$productPrice",
            style: GoogleFonts.figtree(
                fontSize: 14.0, color: AppColors().textColor),
          ),
          const SizedBox(
            height: 12.0,
          ),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
                backgroundColor: AppColors().backgroudColor,
                side: BorderSide(color: AppColors().buttonColor)),
            child: Text(
              "Buy",
              style: GoogleFonts.figtree(
                color: AppColors().primaryColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
