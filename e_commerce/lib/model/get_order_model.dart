class GetorderModel {
  bool? status;
  String? message;
  List<OrdersList>? orders;

  GetorderModel({this.status, this.message, this.orders});

  GetorderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <OrdersList>[];
      json['orders'].forEach((v) {
        orders!.add(OrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersList {
  int? id;
  String? totalAmount;
  String? orderNumber;
  String? status;
  String? createdAt;
  List<Product>? product;

  OrdersList({
    this.id,
    this.totalAmount,
    this.orderNumber,
    this.status,
    this.createdAt,
    this.product,
  });

  OrdersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    orderNumber = json['order_number'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_amount'] = totalAmount;
    data['order_number'] = orderNumber;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? quantity;
  String? price;
  String? image;

  Product({this.id, this.name, this.quantity, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
