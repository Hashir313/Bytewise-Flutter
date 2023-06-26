import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/screens/checkout_screen/checkout_screen.dart';
import 'package:e_commercw_app/widgets/flutter_toast.dart';
import 'package:e_commercw_app/widgets/view_product_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final SingleProductModel singleProductModel;
  const ProductDetails({super.key, required this.singleProductModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          widget.singleProductModel.productName,
          style: TextStyle(
            fontFamily: "Zolina Bold",
            color: AppColors().primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: AppColors().primaryColor,
          ),
        ),
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.singleProductModel.productImage,
                      height: height * 0.2,
                      width: width * 0.2,
                    ),
                    Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                          color: AppColors().backgroudColor.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: IconButton(
                        style: ButtonStyle(
                          iconSize: MaterialStatePropertyAll(height * 0.03),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.singleProductModel.isFavourite =
                                !widget.singleProductModel.isFavourite;
                          });
                          if (widget.singleProductModel.isFavourite) {
                            appProvider.addProductToFavourite(
                                widget.singleProductModel);
                          } else {
                            appProvider.removeProductFromFavourite(
                                widget.singleProductModel);
                          }
                        },
                        icon: Icon(
                            appProvider.getFavouriteProductList
                                    .contains(widget.singleProductModel)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: AppColors().buttonColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 40.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        widget.singleProductModel.productName,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.figtree(
                            color: AppColors().backgroudColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ViewProductButton(
                      buttonText: "Buy Now",
                      onTap: () {
                        SingleProductModel productModel =
                            widget.singleProductModel.copyWith(
                          productQuantity: productQuantity,
                        );
                        appProvider.addProductToCart(productModel);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOutScreen(
                              productModel: widget.singleProductModel,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ViewProductButton(
                      buttonText: "Add to Cart",
                      onTap: () {
                        SingleProductModel productModel =
                            widget.singleProductModel.copyWith(
                          productQuantity: productQuantity,
                        );
                        appProvider.addProductToCart(productModel);
                        showToastMessage("Added to Cart");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              widget.singleProductModel.productDescription,
              textAlign: TextAlign.justify,
              style: GoogleFonts.figtree(
                  color: AppColors().backgroudColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (productQuantity >= 1) {
                      setState(() {
                        productQuantity--;
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors().buttonColor,
                    child: Icon(
                      Icons.remove,
                      color: AppColors().backgroudColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  productQuantity.toString(),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      productQuantity++;
                    });
                    productQuantity = productQuantity++;
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors().buttonColor,
                    child: Icon(
                      Icons.add,
                      color: AppColors().backgroudColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
