// ignore_for_file: use_build_context_synchronously

import "package:e_commercw_app/constants/colors.dart";
import "package:e_commercw_app/constants/constants.dart";
import "package:e_commercw_app/firebase_helper/firebase_auth.dart";
import "package:e_commercw_app/screens/custom_bottom_bar/custom_bottom_bar.dart";
import "package:e_commercw_app/widgets/small_button.dart";
import "package:e_commercw_app/widgets/top_titles.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
//show password
  bool showPassword = true;

//Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors().primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors().primaryColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors().backgroudColor),
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors().primaryColor,
              )),
            ),
          ),
          leadingWidth: 70.0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_background.png"),
                scale: 1.5,
                opacity: 0.5),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleAndSubTitle(
                        title: "Welcome to Hash Tech,",
                        subTitle: "Register to use our services",
                        subTitleColor: AppColors().backgroudColor,
                        titleColor: AppColors().backgroudColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.54,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Card(
                                color:
                                    AppColors().backgroudColor.withOpacity(0.8),
                                elevation: 0.0,
                                child: Form(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: name,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintText: "Enter your name",
                                          hintStyle: GoogleFonts.figtree(
                                              color: Colors.grey),
                                          focusColor: AppColors().primaryColor,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors()
                                                      .primaryColor)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextField(
                                        controller: email,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintText: "Enter your email",
                                          hintStyle: GoogleFonts.figtree(
                                              color: Colors.grey),
                                          focusColor: AppColors().primaryColor,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors()
                                                      .primaryColor)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextField(
                                        controller: password,
                                        obscureText: showPassword,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintText: "Enter your password",
                                          hintStyle: GoogleFonts.figtree(
                                              color: Colors.grey),
                                          focusColor: AppColors().primaryColor,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors()
                                                      .primaryColor)),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: showPassword == true
                                                  ? Icon(
                                                      Icons
                                                          .visibility_off_rounded,
                                                      color: AppColors()
                                                          .primaryColor,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_rounded,
                                                      color: AppColors()
                                                          .primaryColor,
                                                    )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextField(
                                        controller: confirmPassword,
                                        obscureText: showPassword,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintText: "Confirm your password",
                                          hintStyle: GoogleFonts.figtree(
                                              color: Colors.grey),
                                          focusColor: AppColors().primaryColor,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors()
                                                      .primaryColor)),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: showPassword == true
                                                  ? Icon(
                                                      Icons
                                                          .visibility_off_rounded,
                                                      color: AppColors()
                                                          .primaryColor,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_rounded,
                                                      color: AppColors()
                                                          .primaryColor,
                                                    )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50.0,
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SmallButtonWidget(
                              onTap: () async {
                                bool isValidate = signUpValidator(
                                    email.text.toString(),
                                    password.text.toString(),
                                    confirmPassword.text.toString());
                                bool isLogin = await FirebaseAuthHelper.helper
                                    .signup(
                                        name.text.toString(),
                                        email.text.toString(),
                                        password.text.toString(),
                                        context);
                                if (isValidate == true) {
                                  if (isLogin == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomBottomBar(),
                                      ),
                                    );
                                  }
                                }
                              },
                              buttonText: "Register",
                              loading: false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "You can sign in with:",
                        style: GoogleFonts.figtree(
                          color: AppColors().backgroudColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.facebook,
                              color: Colors.blue,
                              size: 35.0,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors().backgroudColor),
                              iconSize: const MaterialStatePropertyAll(35.0),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                height: 48,
                                width: 48,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Image.asset(
                                    "assets/images/goole_icon.png")),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
