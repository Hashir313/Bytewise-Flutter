import 'dart:convert';

SingleProductModel singleProductModelFromJson(String str) =>
    SingleProductModel.fromJson(json.decode(str));

String singleProductModelToJson(SingleProductModel data) =>
    json.encode(data.toJson());

class SingleProductModel {
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final String productDescription;
  final String productStatus;
  bool isFavourite;
  int? productQuantity;

  SingleProductModel(
      {required this.productId,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productDescription,
      required this.productStatus,
      required this.isFavourite,
      this.productQuantity});

  factory SingleProductModel.fromJson(Map<String, dynamic> json) =>
      SingleProductModel(
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: double.parse(json["productPrice"].toString()),
        productDescription: json["productDescription"],
        productStatus: json["productStatus"],
        isFavourite: false,
        productQuantity: json["productQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "productDescription": productDescription,
        "productStatus": productStatus,
        "isFavourite": isFavourite,
        "productQuantity": productQuantity,
      };

  SingleProductModel copyWith({
    int? productQuantity,
  }) =>
      SingleProductModel(
        productId: productId,
        productName: productName,
        productImage: productImage,
        productPrice: productPrice,
        productDescription: productDescription,
        productStatus: productStatus,
        isFavourite: isFavourite,
        productQuantity: productQuantity ?? this.productQuantity,
      );
}
