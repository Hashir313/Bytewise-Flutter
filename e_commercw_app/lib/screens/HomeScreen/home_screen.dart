// ignore_for_file: prefer_const_constructors

import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/firebase_helper/category_firebase_firestore.dart';
import 'package:e_commercw_app/firebase_helper/product_firebase_firestore.dart';
import 'package:e_commercw_app/models/category_model/category_model.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/screens/product_details/product_details.dart';
import 'package:e_commercw_app/screens/view_category/view_category.dart';
import 'package:e_commercw_app/widgets/single_product_widget.dart';
import 'package:e_commercw_app/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SingleProductModel> productModelList = [];
  List<CategoryModel> categoriesList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTopSellingList();
    getCategoryList();
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    provider.getUserInfoFirebase;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: height * 0.1,
                width: width * 0.1,
                color: AppColors().backgroudColor,
                child: CircularProgressIndicator(
                  backgroundColor: AppColors().buttonColor,
                  color: AppColors().primaryColor,
                ),
              ),
            )
          : SafeArea(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: height,
                        width: width * 0.35,
                        color: AppColors().primaryColor,
                      ),
                    ),
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 20.0, right: 20.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: TitleAndSubTitle(
                                title: "Welcome,",
                                subTitle: "to Hash Tech",
                                subTitleColor: AppColors().primaryColor,
                                titleColor: AppColors().primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors().primaryColor,
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: AppColors().backgroudColor,
                                ),
                                hintText: "Search",
                                hintStyle: GoogleFonts.figtree(
                                    color: AppColors().backgroudColor,
                                    fontWeight: FontWeight.w500),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor),
                                ),
                                enabled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor),
                                ),
                              ),
                              cursorColor: AppColors().backgroudColor,
                              style: GoogleFonts.figtree(
                                  color: AppColors().backgroudColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              "Categories",
                              style: GoogleFonts.figtree(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors().textColor,
                                  fontSize: 20.0),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics:
                                ScrollPhysics(parent: BouncingScrollPhysics()),
                            child: Row(
                              children: categoriesList
                                  .map(
                                    (e) => Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CupertinoButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewCategory(
                                                      categoryModel: e),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Card(
                                          color: AppColors().primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          elevation: 3.0,
                                          child: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.29,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Image.network(
                                                    e.categoryImage,
                                                    scale: 15.0,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                                Text(
                                                  e.categoryName,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.figtree(
                                                      color: AppColors()
                                                          .backgroudColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20.0),
                            child: Text(
                              "Top Selling",
                              style: GoogleFonts.figtree(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors().textColor,
                                  fontSize: 20.0),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, bottom: 20.0),
                            child: productModelList.isEmpty
                                ? Center(
                                    child:
                                        Text("There are no products available"),
                                  )
                                : GridView.builder(
                                    itemCount: productModelList.length,
                                    padding:
                                        const EdgeInsets.only(bottom: 50.0),
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.55,
                                            mainAxisSpacing: 20.0,
                                            crossAxisSpacing: 30.0),
                                    itemBuilder: (context, index) {
                                      var productInfo = productModelList[index];
                                      return SingleProductWidget(
                                          productName: productInfo.productName,
                                          productImage:
                                              productInfo.productImage,
                                          productPrice:
                                              productInfo.productPrice,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                  singleProductModel:
                                                      productInfo,
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void getTopSellingList() async {
    productModelList =
        await FirebaseFirestoreHelper.firestoreHelper.getTopSelling();
    productModelList.shuffle();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.firestoreHelper.updateTokkenFromFirebase();
    categoriesList =
        await FirestoreCategoryHelper.categoryHelper.categoryList();
    categoriesList.shuffle();
    setState(() {
      isLoading = false;
    });
  }
}



/**/
