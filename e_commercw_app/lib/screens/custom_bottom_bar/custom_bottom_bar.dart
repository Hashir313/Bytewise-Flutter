import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/screens/HomeScreen/home_screen.dart';
import 'package:e_commercw_app/screens/cart_view/cart_view.dart';
import 'package:e_commercw_app/screens/order_screen/order_screen.dart';
import 'package:e_commercw_app/screens/profile_screeen/profile_screeen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const CartScreen(),
        const OrderScreen(),
        const ProfileScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Home",
          activeColorPrimary: AppColors().primaryColor,
          inactiveColorPrimary: AppColors().primaryColor,
          inactiveColorSecondary: AppColors().primaryColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          inactiveIcon: const Icon(Icons.shopping_cart_outlined),
          title: "Cart",
          activeColorPrimary: AppColors().primaryColor,
          inactiveColorPrimary: AppColors().primaryColor,
          inactiveColorSecondary: AppColors().primaryColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.fire_truck),
          inactiveIcon: const Icon(Icons.fire_truck_outlined),
          title: "Orders",
          activeColorPrimary: AppColors().primaryColor,
          inactiveColorPrimary: AppColors().primaryColor,
          inactiveColorSecondary: AppColors().primaryColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Profile",
          activeColorPrimary: AppColors().primaryColor,
          inactiveColorPrimary: AppColors().primaryColor,
          inactiveColorSecondary: AppColors().primaryColor,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,
          backgroundColor: AppColors().backgroudColor,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
