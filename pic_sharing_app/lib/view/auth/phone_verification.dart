import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/resources/widget/button_widget.dart';
import 'package:pic_sharing_app/view/auth/otp_verification.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  bool phoneInputColor = false;
  bool loading = false;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number Verification'),
        backgroundColor: AppColors().primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: phoneInputColor == true
                  ? AppColors().primaryColor
                  : Colors.transparent,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                cursorColor: AppColors().primaryColor,
                controller: phoneController,
                onTapOutside: (value) {
                  setState(() {
                    phoneInputColor = false;
                  });
                },
                onTap: () {
                  setState(() {
                    phoneInputColor = true;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_rounded,
                    color: phoneInputColor == true
                        ? AppColors().primaryColor
                        : Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Enter your email',
                  hintStyle: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      color: phoneInputColor == true
                          ? AppColors().primaryColor
                          : Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: AppColors().primaryColor, width: 2.0)),
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
          ButtonWidget(
            loading: loading,
              buttonText: 'Get OTP Code',
              onTap: () {
                auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().showToastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().showToastMessage(e);
                    },
                    codeSent:
                        (String verificationId, int? token) {
                          setState(() {
                            loading = false;
                          });
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              OtpVerification(verificationId: verificationId,)));
                    });

                setState(() {
                  loading = true;
                });
              })
        ],
      ),
    );
  }
}
