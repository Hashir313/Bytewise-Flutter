import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  int productQuantity = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    //final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Your Profile',
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
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text(
                "Favourite is empty",
                style: GoogleFonts.figtree(
                  color: AppColors().buttonColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (context, index) {
                return SingleFavouriteItem(
                  productModel: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}
