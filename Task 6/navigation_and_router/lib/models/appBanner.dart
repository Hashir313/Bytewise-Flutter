import 'package:flutter/material.dart';
import 'package:navigation_and_router/ui/bannerScreens/screen1.dart';
import 'package:navigation_and_router/ui/bannerScreens/screen2.dart';
import 'package:navigation_and_router/ui/bannerScreens/screen3.dart';

class AppBanner{
  final int id;
  final String title;

  AppBanner(this.id, this.title);
}



//sample data
List<AppBanner> appBannerList =[
  AppBanner(1, 'Title'),
  AppBanner(2, 'Title'),
  AppBanner(3, 'Title'),

];

List<Widget> screens = [
  const Screen1(),
  const Screen2(),
  const Screen3(),
];