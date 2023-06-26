// ignore_for_file: use_build_context_synchronously

import "package:e_commercw_app/constants/colors.dart";
import "package:e_commercw_app/constants/constants.dart";
import "package:e_commercw_app/firebase_helper/firebase_auth.dart";
import "package:e_commercw_app/screens/custom_bottom_bar/custom_bottom_bar.dart";
import "package:e_commercw_app/widgets/small_button.dart";
import "package:e_commercw_app/widgets/top_titles.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//show password
  bool showPassword = true;

//controllers
  final email = TextEditingController();
  final password = TextEditingController();

//button loading
  bool loading = false;

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
                        subTitle: "Login to use our services",
                        subTitleColor: AppColors().backgroudColor,
                        titleColor: AppColors().backgroudColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.44,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 100.0),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Card(
                                color:
                                    AppColors().backgroudColor.withOpacity(0.8),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller: email,
                                          onTap: () {},
                                          decoration: InputDecoration(
                                            hintText: "Enter the email",
                                            hintStyle: GoogleFonts.figtree(
                                                color: Colors.grey),
                                            focusColor:
                                                AppColors().primaryColor,
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors()
                                                        .primaryColor)),
                                          )),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      TextFormField(
                                        controller: password,
                                        obscureText: showPassword,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintText: "Enter the password",
                                          hintStyle: GoogleFonts.figtree(
                                              color: Colors.grey),
                                          focusColor: AppColors().primaryColor,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors().primaryColor),
                                          ),
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
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SmallButtonWidget(
                              onTap: () async {
                                bool isValidate =
                                    loginValidator(email.text, password.text);
                                bool isLogin = await FirebaseAuthHelper.helper
                                    .login(email.text.toString(),
                                        password.text.toString(), context);
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
                              buttonText: "Login",
                              loading: loading),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: GoogleFonts.figtree(
                          fontStyle: FontStyle.italic,
                          color: AppColors().backgroudColor.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Reset password",
                          style: GoogleFonts.figtree(
                            fontWeight: FontWeight.bold,
                            color: AppColors().backgroudColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
