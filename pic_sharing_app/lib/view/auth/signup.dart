import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_sharing_app/model/image_picker/pick_image.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/resources/widget/button_widget.dart';
import 'package:pic_sharing_app/view/auth/phone_verification.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool showPassword = true;
  bool emailInputColor = false;
  bool nameInputColor = false;
  bool passwordInputColor = false;
  bool loading = false;

  //image picker
  Uint8List? _image;

  void signUp() async {
    setState(() {
      loading = true;
    });

    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref('/User' + DateTime.now().millisecondsSinceEpoch.toString());

    firebase_storage.UploadTask uploadTask = reference.putData(_image!);
    Future.value(uploadTask).then((value)async {
      var newUrl = await reference.getDownloadURL();

      User userID = auth.currentUser!;
      firestore.collection('Users').doc(userID.uid).set({
        'name': nameController.text.toString(),
        'email': emailController.text.toString(),
        'image': newUrl.toString()
      }).then((value) {
        Utils().showToastMessage('Account is created');
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().showToastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
      Utils().showToastMessage('Image Uploaded');
    }).onError((error, stackTrace) {
      Utils().showToastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().showToastMessage(error.toString());
      print(error);
    });
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Sign Up Screen'),
          backgroundColor: AppColors().primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 60.0,
                          backgroundColor: AppColors().primaryColor,
                          child: InkWell(
                            onTap: () => selectImage(),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: AppColors().primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: const AssetImage(
                              'assets/images/pic_share_avatar.png'),
                          radius: 60.0,
                          backgroundColor: AppColors().primaryColor,
                          child: InkWell(
                            onTap: () => selectImage(),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: AppColors().primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
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
                          shadowColor: nameInputColor == true
                              ? AppColors().primaryColor
                              : Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter you name';
                              }
                              return null;
                            },
                            cursorColor: AppColors().primaryColor,
                            controller: nameController,
                            onTapOutside: (value) {
                              setState(() {
                                nameInputColor = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                nameInputColor = true;
                                passwordInputColor = false;
                                emailInputColor = false;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_rounded,
                                color: nameInputColor == true
                                    ? AppColors().primaryColor
                                    : Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Enter your name',
                              hintStyle: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  color: nameInputColor == true
                                      ? AppColors().primaryColor
                                      : Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor,
                                      width: 2.0)),
                            ),
                          ),
                        ),
                      ),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter you email';
                              }
                              return null;
                            },
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
                                nameInputColor = false;
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
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  color: emailInputColor == true
                                      ? AppColors().primaryColor
                                      : Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor,
                                      width: 2.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: passwordInputColor == true
                              ? AppColors().primaryColor
                              : Colors.transparent,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter you password';
                              }
                              return null;
                            },
                            cursorColor: AppColors().primaryColor,
                            obscureText: showPassword,
                            controller: passwordController,
                            onTapOutside: (value) {
                              setState(() {
                                passwordInputColor = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                emailInputColor = false;
                                nameInputColor = false;
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
                                        color: passwordInputColor == true
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
                                        color: passwordInputColor == true
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
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Enter your password',
                              hintStyle: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  color: passwordInputColor == true
                                      ? AppColors().primaryColor
                                      : Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: AppColors().primaryColor,
                                      width: 2.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              ButtonWidget(
                  loading: loading,
                  buttonText: 'Sign Up',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signUp();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginScreen()));
                    }
                  }),
              const SizedBox(
                height: 20.0,
              ),
              Divider(
                color: AppColors().secondaryColor,
                indent: 15.0,
                endIndent: 15.0,
                thickness: 1.3,
              ),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneNumberScreen())),
                  child: Text(
                    'Sign In with phone number?',
                    style: GoogleFonts.raleway(
                        color: AppColors().primaryColor,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
