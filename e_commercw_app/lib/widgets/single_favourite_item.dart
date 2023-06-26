import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/product_model/single_product_model.dart';
import '../provider/app_provider.dart';
import 'flutter_toast.dart';

class SingleFavouriteItem extends StatefulWidget {
  final SingleProductModel productModel;
  const SingleFavouriteItem({super.key, required this.productModel});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors().buttonColor,
            width: 3,
          )),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height * 0.2,
              color: AppColors().buttonColor.withOpacity(0.5),
              child: Image.network(
                widget.productModel.productImage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              height: height * 0.2,
              color: AppColors().backgroudColor.withOpacity(0.5),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productModel.productName,
                              style: GoogleFonts.figtree(
                                fontSize: 18.0,
                                color: AppColors().textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                AppProvider appProvider =
                                    Provider.of<AppProvider>(context,
                                        listen: false);
                                appProvider
                                    .removeProductFromFavourite(widget.productModel);
                                showToastMessage("Removed from wishlist");
                              },
                              child: Text(
                                "Remove from wishlist",
                                style: GoogleFonts.figtree(
                                  fontSize: 12.0,
                                  color: AppColors().buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${widget.productModel.productPrice.toString()}",
                        style: GoogleFonts.figtree(
                          fontSize: 18.0,
                          color: AppColors().textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
