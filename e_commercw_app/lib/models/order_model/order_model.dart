import 'package:e_commercw_app/models/product_model/single_product_model.dart';

class OrderModel {
  OrderModel({
    required this.payment,
    required this.status,
    required this.orderId,
    required this.products,
    required this.totalPrice,
  });

  String payment;
  String status;
  List<SingleProductModel> products;
  String orderId;
  double totalPrice;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        payment: json["payment"],
        status: json["status"],
        products:
            productMap.map((e) => SingleProductModel.fromJson(e)).toList(),
        totalPrice: json["totalPrice"]);
  }
}
