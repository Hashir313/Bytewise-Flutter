import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/firebase_helper/firebase_auth.dart';
import 'package:e_commercw_app/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(
      context,
    );

    

    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors().backgroudColor,
        title: Text(
          "Profile",
          style: GoogleFonts.figtree(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: provider.getUserInformation?.userImage == null
                        ? Icon(
                            Icons.person_outline_rounded,
                            size: 100.0,
                            color: AppColors().primaryColor,
                          )
                        : Image.network(provider.getUserInformation!.userImage!),
                  ),
                  Text(
                    provider.getUserInformation!.userName,
                    style: GoogleFonts.figtree(
                        color: AppColors().textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    provider.getUserInformation!.userEmail,
                    style: GoogleFonts.figtree(
                      color: AppColors().textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SmallButtonWidget(
                    onTap: () {},
                    buttonText: "Edit Profile",
                    loading: false,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 30.0,
                    ),
                    iconColor: AppColors().primaryColor,
                    title: const Text("Your orders"),
                    titleTextStyle: GoogleFonts.figtree(
                      color: AppColors().textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.favorite_outline,
                      size: 30.0,
                    ),
                    iconColor: AppColors().primaryColor,
                    title: const Text("Favourites"),
                    titleTextStyle: GoogleFonts.figtree(
                      color: AppColors().textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.info_outline,
                      size: 30.0,
                    ),
                    iconColor: AppColors().primaryColor,
                    title: const Text("About us"),
                    titleTextStyle: GoogleFonts.figtree(
                      color: AppColors().textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.support_outlined,
                      size: 30.0,
                    ),
                    iconColor: AppColors().primaryColor,
                    title: const Text("Support"),
                    titleTextStyle: GoogleFonts.figtree(
                      color: AppColors().textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.helper.logout();
                    },
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 30.0,
                    ),
                    iconColor: AppColors().primaryColor,
                    title: const Text("Logout"),
                    titleTextStyle: GoogleFonts.figtree(
                      color: AppColors().textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Version 1.0.0",
                    style: GoogleFonts.figtree(
                      color: AppColors().primaryColor,
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
