class ViewCartModel {
  bool? status;
  String? message;
  List<ViewCartData>? viewCartData;

  ViewCartModel({this.status, this.message, this.viewCartData});

  ViewCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      viewCartData = <ViewCartData>[];
      json['data'].forEach((v) {
        viewCartData!.add(ViewCartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (viewCartData != null) {
      data['data'] = viewCartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewCartData {
  int? id;
  int? productId;
  String? name;
  String? price;
  int? quantity;
  String? image;

  ViewCartData({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.quantity,
    this.image,
  });

  ViewCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    return data;
  }
}
