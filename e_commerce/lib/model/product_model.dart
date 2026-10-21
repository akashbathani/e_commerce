// // To parse this JSON data, do
// //
// //     final productModel = productModelFromJson(jsonString);

// import 'dart:convert';

// ProductModel productModelFromJson(String str) =>
//     ProductModel.fromJson(json.decode(str));

// String productModelToJson(ProductModel data) => json.encode(data.toJson());

// class ProductModel {
//   List<Product>? products;
//   int? total;
//   int? skip;
//   int? limit;

//   ProductModel({this.products, this.total, this.skip, this.limit});

//   ProductModel copyWith({
//     List<Product>? products,
//     int? total,
//     int? skip,
//     int? limit,
//   }) => ProductModel(
//     products: products ?? this.products,
//     total: total ?? this.total,
//     skip: skip ?? this.skip,
//     limit: limit ?? this.limit,
//   );

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//     products: json["products"] == null
//         ? []
//         : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
//     total: json["total"],
//     skip: json["skip"],
//     limit: json["limit"],
//   );

//   Map<String, dynamic> toJson() => {
//     "products": products == null
//         ? []
//         : List<dynamic>.from(products!.map((x) => x.toJson())),
//     "total": total,
//     "skip": skip,
//     "limit": limit,
//   };
// }

// class Product {
//   int? id;
//   String? title;
//   String? description;
//   Category? category;
//   double? price;
//   double? discountPercentage;
//   double? rating;
//   int? stock;
//   List<String>? tags;
//   String? brand;
//   String? sku;
//   int? weight;
//   String? warrantyInformation;
//   String? shippingInformation;
//   List<Review>? reviews;
//   int? minimumOrderQuantity;
//   List<String>? images;
//   String? thumbnail;

//   Product({
//     this.id,
//     this.title,
//     this.description,
//     this.category,
//     this.price,
//     this.discountPercentage,
//     this.rating,
//     this.stock,
//     this.tags,
//     this.brand,
//     this.sku,
//     this.weight,
//     this.warrantyInformation,
//     this.shippingInformation,
//     this.reviews,
//     this.minimumOrderQuantity,
//     this.images,
//     this.thumbnail,
//   });

//   Product copyWith({
//     int? id,
//     String? title,
//     String? description,
//     Category? category,
//     double? price,
//     double? discountPercentage,
//     double? rating,
//     int? stock,
//     List<String>? tags,
//     String? brand,
//     String? sku,
//     int? weight,
//     String? warrantyInformation,
//     String? shippingInformation,
//     List<Review>? reviews,
//     int? minimumOrderQuantity,
//     List<String>? images,
//     String? thumbnail,
//   }) => Product(
//     id: id ?? this.id,
//     title: title ?? this.title,
//     description: description ?? this.description,
//     category: category ?? this.category,
//     price: price ?? this.price,
//     discountPercentage: discountPercentage ?? this.discountPercentage,
//     rating: rating ?? this.rating,
//     stock: stock ?? this.stock,
//     tags: tags ?? this.tags,
//     brand: brand ?? this.brand,
//     sku: sku ?? this.sku,
//     weight: weight ?? this.weight,
//     warrantyInformation: warrantyInformation ?? this.warrantyInformation,
//     shippingInformation: shippingInformation ?? this.shippingInformation,
//     reviews: reviews ?? this.reviews,
//     minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
//     images: images ?? this.images,
//     thumbnail: thumbnail ?? this.thumbnail,
//   );

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     category: categoryValues.map[json["category"]],
//     price: json["price"]?.toDouble(),
//     discountPercentage: json["discountPercentage"]?.toDouble(),
//     rating: json["rating"]?.toDouble(),
//     stock: json["stock"],
//     tags: json["tags"] == null
//         ? []
//         : List<String>.from(json["tags"]!.map((x) => x)),
//     brand: json["brand"],
//     sku: json["sku"],
//     weight: json["weight"],

//     warrantyInformation: json["warrantyInformation"],
//     shippingInformation: json["shippingInformation"],
//     reviews: json["reviews"] == null
//         ? []
//         : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
//     minimumOrderQuantity: json["minimumOrderQuantity"],
//     images: json["images"] == null
//         ? []
//         : List<String>.from(json["images"]!.map((x) => x)),
//     thumbnail: json["thumbnail"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "category": categoryValues.reverse[category],
//     "price": price,
//     "discountPercentage": discountPercentage,
//     "rating": rating,
//     "stock": stock,
//     "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//     "brand": brand,
//     "sku": sku,
//     "weight": weight,
//     "warrantyInformation": warrantyInformation,
//     "shippingInformation": shippingInformation,
//     "reviews": reviews == null
//         ? []
//         : List<dynamic>.from(reviews!.map((x) => x.toJson())),
//     "minimumOrderQuantity": minimumOrderQuantity,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//     "thumbnail": thumbnail,
//   };
// }

// enum Category { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

// final categoryValues = EnumValues({
//   "beauty": Category.BEAUTY,
//   "fragrances": Category.FRAGRANCES,
//   "furniture": Category.FURNITURE,
//   "groceries": Category.GROCERIES,
// });

// class Review {
//   int? rating;
//   String? comment;
//   DateTime? date;
//   String? reviewerName;
//   String? reviewerEmail;

//   Review({
//     this.rating,
//     this.comment,
//     this.date,
//     this.reviewerName,
//     this.reviewerEmail,
//   });

//   Review copyWith({
//     int? rating,
//     String? comment,
//     DateTime? date,
//     String? reviewerName,
//     String? reviewerEmail,
//   }) => Review(
//     rating: rating ?? this.rating,
//     comment: comment ?? this.comment,
//     date: date ?? this.date,
//     reviewerName: reviewerName ?? this.reviewerName,
//     reviewerEmail: reviewerEmail ?? this.reviewerEmail,
//   );

//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//     rating: json["rating"],
//     comment: json["comment"],
//     date: json["date"] == null ? null : DateTime.parse(json["date"]),
//     reviewerName: json["reviewerName"],
//     reviewerEmail: json["reviewerEmail"],
//   );

//   Map<String, dynamic> toJson() => {
//     "rating": rating,
//     "comment": comment,
//     "date": date?.toIso8601String(),
//     "reviewerName": reviewerName,
//     "reviewerEmail": reviewerEmail,
//   };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
class ProductModel {
  bool? status;
  String? message;
  List<ProductData>? productData;

  ProductModel({this.status, this.message, this.productData});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      productData = <ProductData>[];
      json['data'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? id;
  String? name;
  String? price;
  String? image;
  String? categoryId;
  String? status;
  String? createdAt;
  String? updatedAt;

  ProductData({
    this.id,
    this.name,
    this.price,
    this.image,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
