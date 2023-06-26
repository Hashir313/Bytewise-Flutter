import 'package:e_commercw_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontFamily: "Zolina Bold",
            color: AppColors().primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: AppColors().primaryColor,
          ),
        ),
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Welcome to Hash Tech',
                style: GoogleFonts.figtree(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors().buttonColor
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Story',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors().textColor
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Hash Tech is a leading e-commerce platform that aims to revolutionize the way you shop online. With our cutting-edge technology and user-friendly interface, we strive to provide the best shopping experience for our customers.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'At Hash Tech, our mission is to connect people with their favorite products in the most convenient and efficient way possible. We are dedicated to offering a wide range of high-quality products at competitive prices, ensuring customer satisfaction at every step.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Values',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Customer Centricity: We put our customers at the heart of everything we do. Your satisfaction is our top priority, and we go the extra mile to exceed your expectations.\n'
              '- Innovation: We embrace innovation and continuously improve our platform to provide you with the latest features and a seamless shopping experience.\n'
              '- Trust and Reliability: We value the trust you place in us. We prioritize transparency, security, and reliability in all our operations.\n'
              '- Community Engagement: We believe in building a strong community of shoppers and sellers. We encourage interaction, feedback, and collaboration to create a vibrant online marketplace.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Services',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Extensive Product Range: Discover a vast selection of products across various categories, including electronics, fashion, home decor, beauty, and more.\n'
              '- Secure Payment Options: Shop with confidence using our secure and reliable payment gateways, ensuring the safety of your transactions.\n'
              '- Fast and Reliable Delivery: Experience prompt and hassle-free delivery right to your doorstep. We work with trusted logistics partners to ensure your orders reach you on time.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Have a question, feedback, or need assistance? We\'re here to help! Reach out to our friendly customer support team via email, phone, or live chat. We strive to provide timely and personalized support to address all your queries.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Join Hash Tech today and embark on an amazing online shopping journey like never before!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
