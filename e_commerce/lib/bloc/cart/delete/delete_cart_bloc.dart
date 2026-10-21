import 'package:e_commerce/bloc/cart/delete/delete_cart_event.dart';
import 'package:e_commerce/bloc/cart/delete/delete_cart_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/delete_cart_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteCartBloc extends Bloc<DeleteCartEvent, DeleteCartState> {
  ApiService apiService;
  DeleteCartBloc({required this.apiService}) : super(DeleteCartInitialState()) {
    on<DeleteCartEventt>((event, emit) async {
      emit(DeleteCartLoadingState());
      print("===> Laoding...");

      try {
        print("===> try");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null || token.isEmpty) {
          emit(DeleteCartFailureState(errorMsg: "Token is missing"));
          return;
        }

        var data = await apiService.postApi(
          url: AppUrl.URL_DELETE,
          token: token,
          mBodyoarams: {"cart_id": event.cartId},
        );
        print("===>  delete cart response: ${data.toString()}");

        DeleteCartModel deleteCartModel = DeleteCartModel.fromJson(data);

        if (deleteCartModel.status == true) {
          print("===> true");

          emit(
            DeleteCartSuccessState(
              successMsg: deleteCartModel.message ?? "Delete cart successfully",
            ),
          );
        } else {
          print("===> fail");

          emit(
            DeleteCartFailureState(
              errorMsg: deleteCartModel.message ?? "not delete",
            ),
          );
        }
      } catch (e) {
        emit(DeleteCartFailureState(errorMsg: e.toString()));
      }
    });
  }
}
