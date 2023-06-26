import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/resources/widget/button_widget.dart';
import 'package:pic_sharing_app/view/auth/forget_password.dart';
import 'package:pic_sharing_app/view/auth/signup.dart';
import 'package:pic_sharing_app/view/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //view password
  bool showPassword = true;
  bool emailInputColor = false;
  bool passwordInputColor = false;
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().showToastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, stackTrace) {
      Utils().showToastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              AppColors().primaryColor,
                              AppColors().secondaryColor
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/pic_share.png'))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Login',
                        style: GoogleFonts.raleway(
                            fontSize: 26.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: AppColors().secondaryColor),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 20.0),
                                child: Material(
                                  elevation: 10.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: emailInputColor == true
                                      ? AppColors().primaryColor
                                      : Colors.transparent,
                                  child: TextFormField(
                                    cursorColor: AppColors().primaryColor,
                                    controller: emailController,
                                    onTapOutside: (value) {
                                      setState(() {
                                        emailInputColor = false;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        emailInputColor = true;
                                        passwordInputColor = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
                                        color: emailInputColor == true
                                            ? AppColors().primaryColor
                                            : Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      hintText: 'Enter your email',
                                      hintStyle: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w500,
                                          color: emailInputColor == true
                                              ? AppColors().primaryColor
                                              : Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                              color: AppColors().primaryColor,
                                              width: 2.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 20.0),
                                child: Material(
                                  elevation: 10.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: passwordInputColor == true
                                      ? AppColors().primaryColor
                                      : Colors.transparent,
                                  child: TextFormField(
                                    cursorColor: AppColors().primaryColor,
                                    controller: passwordController,
                                    onTapOutside: (value) {
                                      setState(() {
                                        passwordInputColor = false;
                                      });
                                    },
                                    obscureText: showPassword,
                                    onTap: () {
                                      setState(() {
                                        emailInputColor = false;
                                        passwordInputColor = true;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: showPassword == true
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.visibility_off_rounded,
                                                color: passwordInputColor ==
                                                        true
                                                    ? AppColors().primaryColor
                                                    : Colors.grey,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.visibility_rounded,
                                                color: passwordInputColor ==
                                                        true
                                                    ? AppColors().primaryColor
                                                    : Colors.grey,
                                              )),
                                      prefixIcon: Icon(
                                        Icons.lock_rounded,
                                        color: passwordInputColor == true
                                            ? AppColors().primaryColor
                                            : Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      hintText: 'Enter your password',
                                      hintStyle: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w500,
                                          color: passwordInputColor == true
                                              ? AppColors().primaryColor
                                              : Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                              color: AppColors().primaryColor,
                                              width: 2.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter the password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPasswordScreen()));
                              },
                              child: Text(
                                'Forget Password?',
                                style: GoogleFonts.raleway(
                                    fontSize: 15.0,
                                    color: AppColors().primaryColor,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                      ButtonWidget(
                          loading: loading,
                          buttonText: 'Sign In',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              login();
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors().primaryColor),
                                ))
                          ],
                        ),
                      )
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
