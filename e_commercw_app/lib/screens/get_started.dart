import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/constants/routes.dart';
import 'package:e_commercw_app/screens/auth_ui/login.dart';
import 'package:e_commercw_app/screens/auth_ui/signup.dart';
import 'package:e_commercw_app/widgets/large_button.dart';
import 'package:e_commercw_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors().primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndSubTitle(
                title: "Welcome",
                subTitle: "Hash Tech! A place for latest technologies",
                subTitleColor: AppColors().backgroudColor,
                titleColor: AppColors().backgroudColor,
              ),
              Image.asset("assets/images/e_commerce.png"),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: LargeButtonWidget(
                    onTap: () {
                      Routes.instance.push(const LoginScreen(), context);
                    },
                    buttonText: "Login",
                    loading: false),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                "OR",
                style: GoogleFonts.robotoCondensed(
                    color: AppColors().buttonColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: LargeButtonWidget(
                    onTap: () {
                      Routes.instance.push(const SignupScreen(), context);
                    },
                    buttonText: "Signup",
                    loading: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
