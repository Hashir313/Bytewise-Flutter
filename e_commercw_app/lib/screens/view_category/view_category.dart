import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/firebase_helper/product_firebase_firestore.dart';
import 'package:e_commercw_app/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/product_model/single_product_model.dart';
import '../../widgets/single_product_widget.dart';
import '../product_details/product_details.dart';

class ViewCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const ViewCategory({super.key, required this.categoryModel});

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  List<SingleProductModel> productModelList = [];
  bool isLoading = false;

  void getCategoryViewList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.firestoreHelper
        .getCategoryView(widget.categoryModel.categoryId);
    productModelList.shuffle();
    
    setState(() {
      isLoading = false;
      debugPrint(productModelList.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryViewList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryModel.categoryName,
            style: GoogleFonts.figtree(
                fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors().textColor,
              ),
            ),
          ],
        ),
        body: isLoading
            ? SizedBox(
                width: width * 0.2,
                height: height * 0.2,
                child: const CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, bottom: 20.0),
                      child: productModelList.isEmpty
                          ? const Center(
                              child: Text("There are no products available"),
                            )
                          : GridView.builder(
                              itemCount: productModelList.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.55,
                                      mainAxisSpacing: 20.0,
                                      crossAxisSpacing: 30.0),
                              itemBuilder: (context, index) {
                                var productInfo = productModelList[index];
                                return SingleProductWidget(
                                    productName: productInfo.productName,
                                    productImage: productInfo.productImage,
                                    productPrice: productInfo.productPrice,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            singleProductModel: productInfo,
                                          ),
                                        ),
                                      );
                                    });
                              }),
                    ),
                  ],
                ),
              ));
  }
}
