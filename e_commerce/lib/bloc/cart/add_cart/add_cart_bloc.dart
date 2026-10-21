import 'package:e_commerce/bloc/cart/add_cart/add_cart_event.dart';
import 'package:e_commerce/bloc/cart/add_cart/add_cart_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/add_cart_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCartBloc extends Bloc<CartEvent, AddCartState> {
  ApiService apiService;
  AddCartBloc({required this.apiService}) : super(AddCartInitialState()) {
    // ADD

    on<AddCartQuantityEvent>((event, emit) async {
      emit(AddCartLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        final userId = prefs.getString("userId");

        if (token == null || token.isEmpty) {
          emit(AddCartFailureState(errorMsg: "Token is missing"));
          return;
        }

        var data = await apiService.postApi(
          url: AppUrl.URL_ADD_TO_CART,
          token: token,
          mBodyoarams: {
            "user_id": userId,
            "product_id": event.productId,
            "quantity": event.qty,
          },
        );

        AddCartModel cart = AddCartModel.fromJson(data);
        if (cart.status == true) {
          emit(AddCartLoadedState(cartModel: cart));
        } else {
          emit(
            AddCartFailureState(
              errorMsg: cart.message ?? "Problem with add cart",
            ),
          );
        }
      } catch (e) {
        emit(AddCartFailureState(errorMsg: e.toString()));
      }
    });

    // INCREASE

    // DECREASE
  }
}
