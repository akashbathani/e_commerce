import 'package:e_commerce/model/product_model.dart';

abstract class ProductState {}

final class ProductInitialState extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<ProductData> productData;
  ProductLoadedState({required this.productData});
}

final class ProductFailureState extends ProductState {
  final String errorMsg;
  ProductFailureState({required this.errorMsg});
}
