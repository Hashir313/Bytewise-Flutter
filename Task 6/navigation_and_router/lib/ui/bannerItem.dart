import 'package:flutter/material.dart';
import 'package:navigation_and_router/models/appBanner.dart';

class BannerItem extends StatelessWidget {
  final AppBanner appBanner;
  const BannerItem({
    super.key, required this.appBanner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient:  LinearGradient(colors: [
          Colors.purple.shade200,
          Colors.purpleAccent.shade200,
          Colors.purpleAccent.shade700
        ],begin: Alignment.topRight , end: Alignment.bottomLeft)
      ),
      child: DefaultTextStyle(
          style:
          const TextStyle(color: Colors.white, fontSize: 20.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Data Science'.toUpperCase(),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        appBanner.title.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}