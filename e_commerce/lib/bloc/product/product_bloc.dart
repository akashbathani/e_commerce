import 'package:e_commerce/bloc/product/product_event.dart';
import 'package:e_commerce/bloc/product/product_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ApiService apiService;
  ProductBloc({required this.apiService}) : super(ProductInitialState()) {
    on<ProductFetchEvent>((event, emit) async {
      emit(ProductLoadingState());
      print("1 ====> Event Started");

      try {
        print("2 ====> Try Started");

        final prefs = await SharedPreferences.getInstance();
        print("3 ====> SharedPreferences Loaded");

        final token = prefs.getString("token");
        print("4 ====> Token: $token");

        if (token == null || token.isEmpty) {
          print("5 ====> Token Missing");

          emit(ProductFailureState(errorMsg: "Token is missing"));
          return;
        }

        print("6 ====> Calling API");

        final data = await apiService.postApi(
          url: AppUrl.URL_PRODUCT,
          token: token,
        );

        ProductModel product = ProductModel.fromJson(data);
        if (product.status == true) {
          emit(ProductLoadedState(productData: product.productData ?? []));
        } else {
          emit(ProductFailureState(errorMsg: product.message ?? "found"));
        }

        print("7 ====> API Response: $data");
      } catch (e, stackTrace) {
        print("ERROR ====> $e");
        print(stackTrace);

        emit(ProductFailureState(errorMsg: e.toString()));
      }
    });
  }
}
