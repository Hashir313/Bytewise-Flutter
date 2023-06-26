import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';

bool loginValidator(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showToastMessage("Email and Password is empty");
    return false;
  } else if (email.isEmpty) {
    showToastMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    showToastMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidator(String email, String password , String confirmPassword) {
  if (email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
    showToastMessage("Email and Password is empty");
    return false;
  } else if (email.isEmpty) {
    showToastMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    showToastMessage("Password is empty");
    return false;
  }else if (confirmPassword.isEmpty) {
    showToastMessage("Confirm Password is empty");
    return false;
  }else if (password != confirmPassword) {
    showToastMessage("Password doesn't match");
    return false;
  }else {
    return true;
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height*0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors().buttonColor,
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7.0),
              child: const Text("Loading......"),
            )
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
