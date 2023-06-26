import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/screens/about_us/about_us.dart';
import 'package:e_commercw_app/screens/edit_profile/edit_profile.dart';
import 'package:e_commercw_app/screens/favourite_screen/favourite_screen.dart';
import 'package:e_commercw_app/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../firebase_helper/firebase_auth.dart';
import '../../models/user_model/user_model.dart';
import '../../provider/app_provider.dart';
import '../../widgets/small_button.dart';

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
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
      body: FutureBuilder<UserModel?>(
        future: provider.getUserInfoFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Replace with your preferred loading indicator widget
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching user information'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            UserModel user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: user.userImage == null
                              ? Icon(
                                  Icons.person_outline_rounded,
                                  size: 100.0,
                                  color: AppColors().buttonColor,
                                )
                              : CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(user.userImage!),
                                ),
                        ),
                        Text(
                          user.userName,
                          style: GoogleFonts.figtree(
                              color: AppColors().textColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.userEmail,
                          style: GoogleFonts.figtree(
                            color: AppColors().textColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SmallButtonWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                          buttonText: "Edit Profile",
                          loading: false,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderScreen(),
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 30.0,
                          ),
                          iconColor: AppColors().buttonColor,
                          title: const Text("Your orders"),
                          titleTextStyle: GoogleFonts.figtree(
                            color: AppColors().textColor,
                            fontSize: 16.0,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavouriteScreen(),
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.favorite_outline,
                            size: 30.0,
                          ),
                          iconColor: AppColors().buttonColor,
                          title: const Text("Favourites"),
                          titleTextStyle: GoogleFonts.figtree(
                            color: AppColors().textColor,
                            fontSize: 16.0,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsScreen(),
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.info_outline,
                            size: 30.0,
                          ),
                          iconColor: AppColors().buttonColor,
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
                          iconColor: AppColors().buttonColor,
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
                          iconColor: AppColors().buttonColor,
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
                            color: AppColors().buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No user information available'),
            );
          }
        },
      ),
    );
  }
}
