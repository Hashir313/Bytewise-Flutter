import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/resources/widget/button_widget.dart';
import 'package:pic_sharing_app/view/home/home_screen.dart';

class OtpVerification extends StatefulWidget {
  final String verificationId;

  const OtpVerification({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController otpController = TextEditingController();
  bool otpInputColor = false;
  bool loading = false;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: AppColors().primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: otpInputColor == true
                  ? AppColors().primaryColor
                  : Colors.transparent,
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: AppColors().primaryColor,
                controller: otpController,
                onTapOutside: (value) {
                  setState(() {
                    otpInputColor = false;
                  });
                },
                onTap: () {
                  setState(() {
                    otpInputColor = true;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_rounded,
                    color: otpInputColor == true
                        ? AppColors().primaryColor
                        : Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Enter your email',
                  hintStyle: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      color: otpInputColor == true
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
              buttonText: 'Verify OTP',
              onTap: () async {
                final authCredentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpController.text.toString());
                setState(() {
                  loading = true;
                });

                try {
                  setState(() {
                    loading = false;
                  });
                  await auth.signInWithCredential(authCredentials);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HomeScreen()));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().showToastMessage(e.toString());
                }
              })
        ],
      ),
    );
  }
}
