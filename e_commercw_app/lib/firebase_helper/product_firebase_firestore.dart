import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercw_app/constants/constants.dart';
import 'package:e_commercw_app/models/product_model/single_product_model.dart';
import 'package:e_commercw_app/widgets/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../models/order_model/order_model.dart';
import '../models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper firestoreHelper = FirebaseFirestoreHelper();
  final _firestore = FirebaseFirestore.instance;
  Future<List<SingleProductModel>> getTopSelling() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collectionGroup("products").get();

      List<SingleProductModel> topSellingList = querySnapshot.docs
          .map((e) => SingleProductModel.fromJson(e.data()))
          .toList();

      return topSellingList;
    } catch (error) {
      showToastMessage(error.toString());
      debugPrint(error.toString());
      return [];
    }
  }

  Future<List<SingleProductModel>> getCategoryView(String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("categories")
          .doc(categoryId)
          .collection("products")
          .get();

      List<SingleProductModel> getCategoryViewList = querySnapshot.docs
          .map((e) => SingleProductModel.fromJson(e.data()))
          .toList();

      return getCategoryViewList;
    } catch (error) {
      showToastMessage(error.toString());
      debugPrint(error.toString());
      return [];
    }
  }

  Future<UserModel> getUserInfo() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    return UserModel.fromJson(documentSnapshot.data()!);
  }

  Future<bool> uploadBuyProductFirebase(List<SingleProductModel> list,
      BuildContext context, String paymentMethod) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.productPrice * element.productQuantity!;
      }
      DocumentReference documentReference = _firestore
          .collection("userOrders")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("orders")
          .doc();
      DocumentReference admin = _firestore.collection("orders").doc();
      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": paymentMethod,
        "orderId": admin.id,
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": paymentMethod,
        "orderId": documentReference.id,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showToastMessage("Your order has been placed");
      return true;
    } catch (e) {
      showToastMessage(
        e.toString(),
      );
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  /////Get order form firebase//////

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("userOrders")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("orders")
          .get();

      List<OrderModel> orderList = querySnapshot.docs
          .map(
            (e) => OrderModel.fromJson(
              e.data(),
            ),
          )
          .toList();

      return orderList;
    } catch (e) {
      showToastMessage(e.toString());
      return [];
    }
  }

  void updateTokkenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        "notificationToken": token,
      });
    } else {}
  }
}
