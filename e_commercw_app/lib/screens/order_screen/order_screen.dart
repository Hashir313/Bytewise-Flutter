import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/firebase_helper/product_firebase_firestore.dart';
import 'package:e_commercw_app/models/order_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Your Orders',
          style: TextStyle(
            fontFamily: "Zolina Bold",
            color: AppColors().primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
      body: FutureBuilder(
          future: FirebaseFirestoreHelper.firestoreHelper.getUserOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors().primaryColor,
                  color: AppColors().buttonColor,
                ),
              );
            }
            if (snapshot.data!.isEmpty ||
                snapshot.data == null ||
                !snapshot.hasData) {
              return const Center(
                child: Text("Oops! You haven't order anything"),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: 70.0, left: 12.0, right: 12.0, top: 12.0),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: AppColors().buttonColor,
                          width: 2.0,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: AppColors().buttonColor,
                          width: 2.0,
                        ),
                      ),
                      title: Row(
                        children: [
                          Container(
                            height: 250,
                            width: 150,
                            color: AppColors().buttonColor.withOpacity(0.5),
                            child: Image.network(
                              orderModel.products[0].productImage,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              height: height * 0.3,
                              color:
                                  AppColors().backgroudColor.withOpacity(0.5),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              orderModel
                                                  .products[0].productName,
                                              style: GoogleFonts.figtree(
                                                fontSize: 14.0,
                                                color: AppColors().textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            orderModel.products.length > 1
                                                ? SizedBox.fromSize()
                                                : Column(
                                                    children: [
                                                      Text(
                                                        "Quantity: ${orderModel.products[0].productQuantity.toString()}",
                                                        style:
                                                            GoogleFonts.figtree(
                                                          fontSize: 12.0,
                                                          color: AppColors()
                                                              .textColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12.0,
                                                      ),
                                                    ],
                                                  ),
                                            Text(
                                              "Total Price: \$${orderModel.totalPrice.toString()}",
                                              style: GoogleFonts.figtree(
                                                fontSize: 12.0,
                                                color: AppColors().textColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            Text(
                                              "Order Status: ${orderModel.status}",
                                              style: GoogleFonts.figtree(
                                                fontSize: 12.0,
                                                color: AppColors().textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: orderModel.products.length > 1
                          ? []
                          : [
                              Text(
                                "Details",
                                style: GoogleFonts.figtree(
                                  color: AppColors().buttonColor,
                                  fontSize: 18.0
                                ),
                              ),
                              Divider(
                                color: AppColors().buttonColor,
                              ),
                              ...orderModel.products.map((singleProduct) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            color: AppColors()
                                                .buttonColor
                                                .withOpacity(0.5),
                                            child: Image.network(
                                              singleProduct.productImage,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              height: height * 0.24,
                                              color: AppColors()
                                                  .backgroudColor
                                                  .withOpacity(0.5),
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              singleProduct
                                                                  .productName,
                                                              style: GoogleFonts
                                                                  .figtree(
                                                                fontSize: 14.0,
                                                                color: AppColors()
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            const SizedBox(
                                                              height: 12.0,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "Quantity: ${singleProduct.productQuantity.toString()}",
                                                                  style: GoogleFonts
                                                                      .figtree(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: AppColors()
                                                                        .textColor,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 12.0,
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              "Price: \$${singleProduct.productPrice.toString()}",
                                                              style: GoogleFonts
                                                                  .figtree(
                                                                fontSize: 12.0,
                                                                color: AppColors()
                                                                    .textColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15.0,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: AppColors().buttonColor,
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ]),
                );
              },
            );
          }),
    );
  }
}
