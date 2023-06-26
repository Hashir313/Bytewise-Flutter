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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        title: Text(
          "Favourite List",
          style: GoogleFonts.figtree(fontWeight: FontWeight.bold),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text(
                "Favourite is empty",
                style: GoogleFonts.figtree(
                  color: AppColors().primaryColor,
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
