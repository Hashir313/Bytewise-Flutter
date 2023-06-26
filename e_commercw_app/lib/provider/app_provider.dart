import 'package:e_commercw_app/firebase_helper/product_firebase_firestore.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:flutter/material.dart';
import '../models/user_model/user_model.dart';

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
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.firestoreHelper.getUserInfo();
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

  void updateQuantity(SingleProductModel productModel , int productQuantity){
    int index = productList.indexOf(productModel);
    productList[index].productQuantity = productQuantity;
    notifyListeners();
  }


  /////Buy product///////
  
  void addBuyProduct(SingleProductModel productModel){
    buyProductList.add(productModel);
    notifyListeners();
  }

  void addBuyProductCartList(){
    buyProductList.addAll(productList);
    notifyListeners();
  }

  void clearCart(){
    productList.clear;
    notifyListeners();
  }

  void clearBuyProduct(){
    buyProductList.clear();
    notifyListeners();
  }

  List<SingleProductModel> get getBuyProductList => buyProductList;

}
