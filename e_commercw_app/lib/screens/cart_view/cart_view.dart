import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:e_commercw_app/widgets/flutter_toast.dart';
import 'package:e_commercw_app/widgets/single_item_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/large_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int productQuantity = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      bottomNavigationBar: appProvider.getCartProductList.isEmpty
          ? Center(
              child: Text(
                "Cart is empty",
                style: GoogleFonts.figtree(
                    color: AppColors().buttonColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              height: height * 0.23,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.figtree(
                            color: AppColors().textColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${appProvider.totalPrice().toString()}",
                        style: GoogleFonts.figtree(
                            color: AppColors().textColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  LargeButtonWidget(
                      onTap: () {
                        appProvider.clearBuyProduct();
                        appProvider.addBuyProductCartList();
                        appProvider.clearCart();

                        if (appProvider.getBuyProductList.isEmpty) {
                          showToastMessage("Cart is empty");
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CartItemCheckOutScreen(),
                            ),
                          );
                        }
                      },
                      buttonText: "Checkout",
                      loading: false)
                ],
              ),
            ),
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontFamily: "Zolina Bold",
            color: AppColors().primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: appProvider.getCartProductList.length,
          itemBuilder: (context, index) {
            return SingleItemCart(
              productModel: appProvider.getCartProductList[index],
            );
          }),
    );
  }
}
