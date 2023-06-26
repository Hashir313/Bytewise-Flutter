import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/product_model/single_product_model.dart';
import '../provider/app_provider.dart';
import 'flutter_toast.dart';

class SingleItemCart extends StatefulWidget {
  final SingleProductModel productModel;
  const SingleItemCart({super.key, required this.productModel});

  @override
  State<SingleItemCart> createState() => _SingleItemCartState();
}

class _SingleItemCartState extends State<SingleItemCart> {
  int productQuantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productQuantity = widget.productModel.productQuantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

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
              height: height * 0.24,
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
              height: height * 0.24,
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
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (productQuantity > 1) {
                                      setState(() {
                                        productQuantity--;
                                        appProvider.updateQuantity(
                                        widget.productModel,
                                        productQuantity,
                                      );
                                      });
                                    }
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 13.0,
                                    backgroundColor: AppColors().buttonColor,
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors().backgroudColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  productQuantity.toString(),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productQuantity++;
                                      appProvider.updateQuantity(
                                        widget.productModel,
                                        productQuantity,
                                      );
                                    });
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 13.0,
                                    backgroundColor: AppColors().buttonColor,
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors().backgroudColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                if (!appProvider.getFavouriteProductList
                                    .contains(widget.productModel)) {
                                  appProvider.addProductToFavourite(
                                      widget.productModel);
                                  showToastMessage("Added to wishlist");
                                } else {
                                  appProvider.removeProductFromFavourite(
                                      widget.productModel);
                                  showToastMessage("Removed from wishlist");
                                }
                              },
                              child: Text(
                                appProvider.getFavouriteProductList
                                        .contains(widget.productModel)
                                    ? "Remove from wishlist"
                                    : "Add to wishlist",
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
                      const SizedBox(width: 15.0,),
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
                  InkWell(
                    onTap: () {
                      appProvider.removeProductFromCart(widget.productModel);
                      showToastMessage("Removed from Cart");
                    },
                    child: CircleAvatar(
                      maxRadius: 13.0,
                      backgroundColor: AppColors().buttonColor,
                      child: Icon(
                        Icons.delete,
                        size: 18,
                        color: AppColors().backgroudColor,
                      ),
                    ),
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
