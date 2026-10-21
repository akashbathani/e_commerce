import 'package:e_commerce/bloc/category/category_event.dart';
import 'package:e_commerce/bloc/category/category_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  ApiService apiService;
  CategoryBloc({required this.apiService}) : super(CategoryInitialState()) {
    on<CategoryFetchEvent>((event, emit) async {
      emit(CategoryLoadingState());

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null || token.isEmpty) {
          emit(CategoryFailureState(errorMsg: "Token is missing"));
          return;
        }

        var data = await apiService.getApi(
          url: AppUrl.URL_CATEGORY,
          token: token,
        );
        CategoryModel categoryList = CategoryModel.fromJson(data);

        if (categoryList.status == true) {
          emit(
            CategoryLoadedState(categoryData: categoryList.categoryData ?? []),
          );
        } else {
          emit(
            CategoryFailureState(
              errorMsg: categoryList.message ?? "Category not available",
            ),
          );
        }
      } catch (e) {
        emit(CategoryFailureState(errorMsg: e.toString()));
      }
    });
  }
}
