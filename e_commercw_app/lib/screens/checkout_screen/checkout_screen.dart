// ignore_for_file: use_build_context_synchronously

import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/firebase_helper/product_firebase_firestore.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:e_commercw_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commercw_app/screens/stripe_helper/stripe_helper.dart';
import 'package:e_commercw_app/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class CheckOutScreen extends StatefulWidget {
  final SingleProductModel productModel;
  const CheckOutScreen({super.key, required this.productModel});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int groupValue = 2;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    //final width = MediaQuery.sizeOf(context).width;

    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Checkout',
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 35.0,
            ),
            Container(
              height: height * 0.13,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: AppColors().buttonColor,
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    activeColor: AppColors().buttonColor,
                    //fillColor: MaterialStatePropertyAll(AppColors().primaryColor),
                    value: 1,
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    }),
                  ),
                  Icon(
                    Icons.money,
                    color: AppColors().buttonColor,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Cash on delivery",
                    style: GoogleFonts.figtree(
                        color: AppColors().textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              height: height * 0.13,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: AppColors().buttonColor,
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    activeColor: AppColors().buttonColor,
                    //fillColor: MaterialStatePropertyAll(AppColors().primaryColor),
                    value: 2,
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    }),
                  ),
                  Icon(
                    Icons.card_membership,
                    color: AppColors().buttonColor,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Pay online",
                    style: GoogleFonts.figtree(
                        color: AppColors().textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            LargeButtonWidget(
              onTap: () async {
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.firestoreHelper
                      .uploadBuyProductFirebase(appProvider.getBuyProductList,
                          context, "Cash on delivery");
                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomBottomBar(),
                        ),
                      );
                    });
                  }
                }else {
                    int value = double.parse(
                            appProvider.totalPriceBuyProductList().toString())
                        .round()
                        .toInt();
                    String totalPrice = (value * 100).toString();
                    //print(totalPrice);
                    await StripeHelper.instance
                        .makePayment(totalPrice.toString() , context);
                  }
              },
              buttonText: "Continue",
              loading: false,
            )
          ],
        ),
      ),
    );
  }
}
