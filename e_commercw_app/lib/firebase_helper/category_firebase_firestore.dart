import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercw_app/models/category_model/category_model.dart';
import 'package:e_commercw_app/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';

class FirestoreCategoryHelper {
  static FirestoreCategoryHelper categoryHelper = FirestoreCategoryHelper();
  final _firestorCategory = FirebaseFirestore.instance;

  Future<List<CategoryModel>> categoryList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestorCategory.collection("categories").get();

      List<CategoryModel> categoryList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoryList;
    } catch (error) {
      showToastMessage(error.toString());
      debugPrint(error.toString());
      return [];
    }
  }
}
