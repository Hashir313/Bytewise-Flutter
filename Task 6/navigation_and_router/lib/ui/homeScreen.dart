// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_and_router/models/appBanner.dart';
import 'package:navigation_and_router/ui/bannerItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            // ya wala container upar ki jo bari app bar ha uska ha
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.shade100,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search Courses',
                          style: GoogleFonts.figtree(
                              color: Colors.white, fontSize: 16),
                        ),
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type Something......',
                            hintStyle: GoogleFonts.figtree(
                              color: Colors.grey[50]!.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Ya sized box wo ha jis ma body wala sara kam huwa wa ha
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6540,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured',
                          style: GoogleFonts.figtree(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 30.0,
                          width: 75.0,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors
                                    .pinkAccent.shade200
                                    .withOpacity(0.55)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)))),
                            child: Text(
                              'See all',
                              style: GoogleFonts.figtree(color: Colors.pink),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          height: 200,
                          width: 250,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.7),
                            onPageChanged: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            itemCount: appBannerList.length,
                            itemBuilder: (context, index) {
                              var banner = appBannerList[index];
                              var scale = _selectedIndex == index ? 1.0 : 0.8;
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                screens[index]));
                                  },
                                  child: TweenAnimationBuilder(
                                    curve: Curves.ease,
                                    tween: Tween(begin: scale, end: scale),
                                    duration: const Duration(milliseconds: 350),
                                    builder: (BuildContext context,
                                        double value, Widget? child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: child,
                                      );
                                    },
                                    child: BannerItem(appBanner: banner),
                                  ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
