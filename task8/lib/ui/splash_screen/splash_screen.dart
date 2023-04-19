import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task8/ui/splash_screen/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double animatedText = 0.0;
  SplashServices splashServices = SplashServices();

  @override
  void initState(){
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/todo_animation.json',
              repeat: false,
            ),
            const SizedBox(height: 50.0,),
            const CircularProgressIndicator(
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}
