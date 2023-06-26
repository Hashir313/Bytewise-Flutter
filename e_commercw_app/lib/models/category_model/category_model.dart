import 'dart:convert';

CategoryModel singleProductModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String singleProductModelToJson(CategoryModel data) =>
    json.encode(data.toJson());

class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryImage": categoryImage,
      };
}
