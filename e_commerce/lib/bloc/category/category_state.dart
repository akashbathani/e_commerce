import 'package:e_commerce/model/category_model.dart';

abstract class CategoryState {}

final class CategoryInitialState extends CategoryState {}

final class CategoryLoadingState extends CategoryState {}

final class CategoryLoadedState extends CategoryState {
  final List<CategoryData> categoryData;
  CategoryLoadedState({required this.categoryData});
}

final class CategoryFailureState extends CategoryState {
  final String errorMsg;
  CategoryFailureState({required this.errorMsg});
}
