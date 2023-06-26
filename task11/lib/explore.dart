// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import 'mercury.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);
  @override
  _ExploreState createState() => _ExploreState();
}

const primaryColor = Color(0xFF6252DA);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF7777B6);

class _ExploreState extends State<Explore> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://th.bing.com/th/id/OIP.1r-quXW57OaXoN4SkuynHgHaFj?pid=ImgDet&rs=1"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Builder(
          builder: (context) {
            final isSmallScreen = MediaQuery.of(context).size.width < 600;
            return Scaffold(
              key: _key,
              backgroundColor: Colors.transparent,
              appBar: isSmallScreen
                  ? AppBar(
                      leading: IconButton(
                        onPressed: () {
                          _key.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    )
                  : null,
              drawer: SideBarXExample(controller: _controller),
              body: Row(
                children: [
                  if (!isSmallScreen) SideBarXExample(controller: _controller),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: EdgeInsets.all(25.sp),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Explore',
                              style: GoogleFonts.openSans(
                                letterSpacing: 8.5.sp,
                                fontSize: 26.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample({Key? key, required SidebarXController controller})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
          decoration: BoxDecoration(
            color: Colors.black38.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.sp),
                bottomRight: Radius.circular(20.sp)),
            boxShadow: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          selectedTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      extendedTheme: SidebarXTheme(width: 100.w),
      footerDivider: Divider(color: Colors.white.withOpacity(0.8), height: 1),
      headerBuilder: (context, extended) {
        return SizedBox(
            height: 100,
            child: Image.network(
              'https://www.pngall.com/wp-content/uploads/5/Astronaut-Vector-Transparent.png',
              width: 15.w,
            )
            //Icon(Icons.spa,size: 30.sp,color: Colors.white)
            );
      },
      items: [
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.ca917ddfc55c2483dd1284b74a6646b3?rik=OZzk%2fl8nZhC2Tw&riu=http%3a%2f%2fwww.pngimagesfree.com%2fNATURE%2fPlanet%2fMercury%2fMercury-Planet-PNG.png&ehk=GNcWPDO6b5%2fD%2fSfKo2u6x71r8TCxl5qL3tOrtQuPZ%2bg%3d&risl=&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Mercury',
            onTap: () {
              Get.to(const Mercury());
            }),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.545f74a860fb4b5e493c10923cb952aa?rik=wCTBobBJLCX2YA&riu=http%3a%2f%2fwww.pngimagesfree.com%2fNATURE%2fPlanet%2fVenus%2fvenus-planet-transparent.png&ehk=1w%2b4w4mUEc2%2bK238MHv3sOzK%2bgcv1B3ZYWkGw7LOvUQ%3d&risl=&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Venus'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.5405546f795e7ea4549a7b43e0d60704?rik=94cUYXPT%2bszjSg&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Earth'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.df324988460d38ba9521f76385bcba28?rik=Jba8mhZDU7ht6Q&riu=http%3a%2f%2fpngimg.com%2fuploads%2fmars_planet%2fmars_planet_PNG26.png&ehk=b9TO1iQCgKGDSMIsgwTibFi3GQW843BWcMW4pX%2fX0bg%3d&risl=&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Mars'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://www.vippng.com/png/full/432-4321909_4k-jupiter.png',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Jupiter'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.35e62ab22f12604539c169d5ac747e9c?rik=PrT46DiB3BWM1g&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Saturn'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/R.3326cb76ba8971235336057e9c3c01ec?rik=euSkEw5GBwOauA&pid=ImgRaw&r=0',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Uranus'),
        SidebarXItem(
            iconWidget: Image.network(
              'https://th.bing.com/th/id/OIP.oGGuXVGfFwnmBlrku47iLAHaHa?pid=ImgDet&rs=1',
              width: 10.w,
              height: 5.h,
            ),
            label: 'Neptune'),
      ],
    );
  }
}
