// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercw_app/constants/constants.dart';
import 'package:e_commercw_app/firebase_helper/firebase_storage_helper.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model/user_model.dart';
import '../widgets/flutter_toast.dart';

class AppProvider with ChangeNotifier {
  UserModel? _userModel;

  UserModel? get getUserInformation => _userModel;

  List<SingleProductModel> buyProductList = [];
  ////Cart list////
  List<SingleProductModel> productList = [];

  void addProductToCart(SingleProductModel productModel) {
    productList.add(productModel);
    notifyListeners();
  }

  void removeProductFromCart(SingleProductModel productModel) {
    productList.remove(productModel);
    notifyListeners();
  }

  List<SingleProductModel> get getCartProductList => productList;

  ////Favourite list////

  List<SingleProductModel> favouriteList = [];

  void addProductToFavourite(SingleProductModel productModel) {
    favouriteList.add(productModel);
    notifyListeners();
  }

  void removeProductFromFavourite(SingleProductModel productModel) {
    favouriteList.remove(productModel);
    notifyListeners();
  }

  List<SingleProductModel> get getFavouriteProductList => favouriteList;

////User Info Model////
  Future<UserModel?> getUserInfoFirebase() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

    if (documentSnapshot.exists) {
      _userModel = UserModel.fromJson(documentSnapshot.data()!);
    } else {
      _userModel = null;
    }

    return _userModel;
  }

  void updateUserInfo(
      UserModel userModel, File? file, BuildContext context) async {
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel?.userId)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageURL =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(userImage: imageURL);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel?.userId)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showToastMessage("Successfully updated profile");
    notifyListeners();
  }

  /////Total Price/////
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in productList) {
      totalPrice += element.productPrice * element.productQuantity!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in buyProductList) {
      totalPrice += element.productPrice * element.productQuantity!;
    }
    return totalPrice;
  }

  void updateQuantity(SingleProductModel productModel, int productQuantity) {
    int index = productList.indexOf(productModel);
    productList[index].productQuantity = productQuantity;
    notifyListeners();
  }

  /////Buy product///////

  void addBuyProduct(SingleProductModel productModel) {
    buyProductList.add(productModel);
    notifyListeners();
  }

  void addBuyProductCartList() {
    buyProductList.addAll(productList);
    notifyListeners();
  }

  void clearCart() {
    productList.clear;
    notifyListeners();
  }

  void clearBuyProduct() {
    buyProductList.clear();
    notifyListeners();
  }

  List<SingleProductModel> get getBuyProductList => buyProductList;
}
