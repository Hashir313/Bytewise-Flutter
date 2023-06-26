import 'package:e_commercw_app/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message){
  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors().buttonColor,
        textColor: AppColors().backgroudColor,
        fontSize: 16.0
    );
}