import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_sharing_app/model/firebase_services/splash_services.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors().primaryColor, AppColors().secondaryColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Center(
          child: Text(
            'Pic Share',
            style:
                GoogleFonts.rakkas(fontSize: 40.0, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
