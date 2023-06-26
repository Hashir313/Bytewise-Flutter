import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';

class Earth extends StatefulWidget {
  const Earth({super.key});

  @override
  State<Earth> createState() => _EarthState();
}

class _EarthState extends State<Earth> {
  final controller = SidebarXController(selectedIndex: 0, extended: true);
  final Key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key,
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.network(
            'https://th.bing.com/th/id/OIP.1r-quXW57OaXoN4SkuynHgHaFj?pid=ImgDet&rs=1',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Earth',
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
  }
}
